"""
Hardware-in-the-loop characterisation of the TT08 8-bit 3.3V R2R DAC
(tt_um_mattvenn_r2r_dac_3v3) on the RP2040 demoboard.

The internal sine generator is bypassed: uio_in[0] (ext_data) is held high and
the RP2040 writes DAC codes straight onto ui_in[7:0] (see r2r_hil.py).

Wiring:
  analog header A5 (ua[0], DAC output) -> scope CH1 (10x probe)
  nothing else needed (all timing is derived from the RP2040's deadline-locked
  sequence and from triggering on the DAC output itself)

Tests:
  static     slow staircase 0..255, scope-averaged, one level per code ->
             offset, full scale, gain error, LSB, DNL, INL, monotonicity, noise
  step       0<->255 full-scale step: rise/fall time, overshoot, settling time
  carry      major-carry transitions (63/64, 127/128, 191/192) in both directions:
             glitch peak (median + worst over single shots), glitch impulse area,
             settling time

Interpreting results:
  - Only `static` asserts on linearity (monotonic, |DNL|, |INL|). First silicon
    (Nov 2026) is NOT monotonic: the MSB is light compared with the lower bits, so
    127->128 steps down ~24 mV (-1.9 LSB) and 63->64 / 191->192 step down ~5.7 mV.
  - step: a fast (~0.8 us) edge followed by a slow (~80 us) tail of ~8% of the swing is
    the signature of an under-compensated 10x probe. Check probe comp before blaming
    the DAC.
  - carry: ui_in is sampled by r2r_out on clk (CLOCK_HZ). The RP2040 writes all 8 bits
    at once, but if the write lands near a clk edge the bits arrive with different
    delays through the TT mux and a mixed code is latched for one clock. That shows up
    as occasional large (~10 LSB, ~100 ns) glitches, counted as "atypical" shots.

Results (CSV, JSON, PNG plots) are written to test/hil_results/<timestamp>/.

Setup:
  source ~/work/asic-workshop/venv/bin/activate
  pip install -r test/requirements-hil.txt

Run:
  pytest test/test_hil.py -v -s
  pytest test/test_hil.py -v -s -k static        # just the transfer function

Environment variables:
  SCOPE_RESOURCE  VISA resource   (default TCPIP0::192.168.50.11::inst0::INSTR)
  MPREMOTE_DEV    serial device   (default the demoboard's /dev/serial/by-id path;
                                   use that rather than /dev/ttyACMx, which changes
                                   after a reset)
  SCOPE_CH        DAC output channel   (default 1)
  CLOCK_HZ        project clock         (default 10 MHz)
  VAPWR           3.3V rail, for gain error (default 3.3)
  STEP_US         staircase step time   (default 200)
  AVERAGES        scope averages        (default 16)
  DNL_LIMIT / INL_LIMIT   pass limits in LSB (default 1.0 / 2.0)
"""

import json
import os
import select
import subprocess
import sys
import time
from pathlib import Path

import numpy as np
import pytest
import pyvisa

SCOPE_RESOURCE = os.environ.get("SCOPE_RESOURCE", "TCPIP0::192.168.50.11::inst0::INSTR")
MPREMOTE_DEV = os.environ.get(
    "MPREMOTE_DEV",
    "/dev/serial/by-id/usb-MicroPython_Board_in_FS_mode_de641070db565f27-if00",
)
SCOPE_CH   = int(os.environ.get("SCOPE_CH", "1"))
CLOCK_HZ   = int(float(os.environ.get("CLOCK_HZ", "10e6")))
VAPWR      = float(os.environ.get("VAPWR", "3.3"))
STEP_US    = int(os.environ.get("STEP_US", "200"))
GAP_US     = 2000
AVERAGES   = int(os.environ.get("AVERAGES", "16"))
DNL_LIMIT  = float(os.environ.get("DNL_LIMIT", "1.0"))
INL_LIMIT  = float(os.environ.get("INL_LIMIT", "2.0"))

STEP_HOLD_US  = 1000     # full-scale step: time at each level
CARRY_HOLD_US = 500      # carry test: time at each level
CARRY_CAPTURES = 16      # carry test: single shots, aligned and averaged on the host
CARRY_PAIRS = [(127, 128), (128, 127), (63, 64), (64, 63), (191, 192), (192, 191)]

NBITS = 8
NCODES = 1 << NBITS
HERE = Path(__file__).resolve().parent
BOARD_MODULE = HERE / "r2r_hil.py"
RESULTS = HERE / "hil_results" / time.strftime("%Y%m%d-%H%M%S")

# filled by test_static, reused by later tests for levels / LSB
_static = {}


# ── board (mpremote) ──────────────────────────────────────────────────────────

def _clean_env():
    env = os.environ.copy()
    env.pop("PYTHONHOME", None)
    env.pop("PYTHONPATH", None)
    return env


def _mpremote_args():
    return [sys.executable, "-m", "mpremote", "connect", MPREMOTE_DEV]


def _mpremote(*cmd, timeout=60):
    r = subprocess.run(_mpremote_args() + list(cmd), capture_output=True, text=True,
                       timeout=timeout, env=_clean_env())
    if r.returncode != 0:
        raise RuntimeError(f"mpremote {' '.join(cmd)} failed (rc={r.returncode})\n"
                           f"stdout: {r.stdout.strip()}\nstderr: {r.stderr.strip()}")
    return r.stdout


def _wait_for_device(timeout=15):
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        if os.path.exists(MPREMOTE_DEV):
            return
        time.sleep(0.2)
    raise RuntimeError(f"{MPREMOTE_DEV} did not come back")


def _board_start(call, ready="PLAYING", timeout=40):
    """
    Run `import r2r_hil; r2r_hil.<call>` on the board and return once it prints
    `ready`. The sequence loop keeps running on the board after mpremote is killed;
    the next mpremote connection interrupts it with Ctrl-C.
    Following the output (rather than exec --no-follow) means board-side errors
    such as a MemoryError are reported instead of silently leaving the DAC idle.
    """
    p = subprocess.Popen(_mpremote_args() + ["exec", f"import r2r_hil; r2r_hil.{call}"],
                         stdout=subprocess.PIPE, stderr=subprocess.STDOUT, env=_clean_env())
    buf = b""
    deadline = time.monotonic() + timeout
    try:
        while time.monotonic() < deadline:
            r, _, _ = select.select([p.stdout], [], [], 0.2)
            if r:
                chunk = os.read(p.stdout.fileno(), 4096)
                if not chunk:
                    break
                buf += chunk
                if ready.encode() in buf:
                    line = [l for l in buf.decode(errors="replace").splitlines() if ready in l]
                    print(f"  [board] {line[-1].strip()}")
                    return
            elif p.poll() is not None:
                break
    finally:
        p.kill()
        p.wait()
    raise RuntimeError(f"board did not start r2r_hil.{call}:\n{buf.decode(errors='replace')}")


def _play(seq):
    _board_start(f"play({seq!r}, {CLOCK_HZ})")


# ── scope ─────────────────────────────────────────────────────────────────────

class Scope:
    def __init__(self, inst, ch):
        self.s = inst
        self.ch = ch
        self.src = f"CHANnel{ch}"

    def w(self, *cmds):
        for c in cmds:
            self.s.write(c)
        err = self.s.query(":SYSTem:ERRor?").strip()
        if not err.startswith("+0"):
            raise RuntimeError(f"scope error after {cmds}: {err}")

    def setup_channel(self, v_range=4.0, v_offset=1.65):
        self.w(f":{self.src}:DISPlay 1", f":{self.src}:BWLimit 0",
               f":{self.src}:RANGe {v_range}", f":{self.src}:OFFSet {v_offset}")

    def window(self, t_start, t_end):
        """Show [t_start, t_end] relative to the trigger (reference is 10% from the left)."""
        rng = t_end - t_start
        self.w(":TIMebase:REFerence LEFT", f":TIMebase:RANGe {rng:.6e}",
               f":TIMebase:POSition {t_start + 0.1 * rng:.6e}")

    def edge_trigger(self, level, slope="POSitive", holdoff=40e-9):
        self.w(":TRIGger:MODE EDGE", f":TRIGger:EDGE:SOURce {self.src}",
               f":TRIGger:EDGE:SLOPe {slope}", f":TRIGger:EDGE:LEVel {level:.4f}",
               f":TRIGger:HOLDoff {holdoff:.6e}", ":TRIGger:SWEep NORMal")

    def acquire(self, averages=1):
        if averages > 1:
            self.w(":ACQuire:TYPE AVERage", f":ACQuire:COUNt {averages}")
        else:
            self.w(":ACQuire:TYPE NORMal")

    def capture(self, points=1_000_000, timeout_s=60):
        """Single acquisition (with averaging if enabled), return (t, v) numpy arrays."""
        old = self.s.timeout
        self.s.timeout = timeout_s * 1000
        try:
            self.s.write(f":DIGitize {self.src}")
            self.s.query("*OPC?")
            self.w(f":WAVeform:SOURce {self.src}", ":WAVeform:FORMat WORD",
                   ":WAVeform:BYTeorder LSBFirst", ":WAVeform:UNSigned ON",
                   ":WAVeform:POINts:MODE RAW", f":WAVeform:POINts {points}")
            pre = [float(x) for x in self.s.query(":WAVeform:PREamble?").split(",")]
            raw = np.asarray(self.s.query_binary_values(
                ":WAVeform:DATA?", datatype="H", is_big_endian=False, container=np.array),
                dtype=float)
        finally:
            self.s.timeout = old
        _fmt, _typ, _n, _cnt, xinc, xorg, xref, yinc, yorg, yref = pre
        t = (np.arange(raw.size) - xref) * xinc + xorg
        v = (raw - yref) * yinc + yorg
        if np.any(raw <= 0) or np.any(raw >= 65535):
            print("  WARNING: waveform clipped")
        return t, v

    def run(self):
        self.s.write(":ACQuire:TYPE NORMal")
        self.s.write(":TRIGger:SWEep AUTO")
        self.s.write(":RUN")


# ── fixtures ──────────────────────────────────────────────────────────────────

@pytest.fixture(scope="session")
def scope():
    rm = pyvisa.ResourceManager()
    inst = rm.open_resource(SCOPE_RESOURCE)
    inst.timeout = 10000
    inst.clear()
    inst.write("*CLS")
    print(f"\nScope: {inst.query('*IDN?').strip()}")
    sc = Scope(inst, SCOPE_CH)
    sc.setup_channel()
    yield sc
    sc.run()
    inst.close()
    rm.close()


@pytest.fixture(scope="session")
def board():
    """Hard reset (frees the heap; the SDK needs most of it), upload r2r_hil.py."""
    _wait_for_device()
    _mpremote("reset")
    time.sleep(2)
    _wait_for_device()
    time.sleep(2)   # let main.py finish booting
    _mpremote("cp", str(BOARD_MODULE), ":r2r_hil.py")
    print(f"\nBoard: uploaded {BOARD_MODULE.name} to {MPREMOTE_DEV}")
    yield
    try:
        _mpremote("exec", "import r2r_hil; r2r_hil.hold(0)")
    except Exception as e:  # don't hide test results behind a cleanup failure
        print(f"board cleanup failed: {e}")


@pytest.fixture(scope="session")
def results_dir():
    RESULTS.mkdir(parents=True, exist_ok=True)
    print(f"\nResults: {RESULTS}")
    return RESULTS


def _plt():
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    return plt


def _ideal_v(code):
    return VAPWR * code / NCODES


def _lsb():
    return _static.get("lsb_v", VAPWR / NCODES)


# ── analysis helpers ──────────────────────────────────────────────────────────

def _step_metrics(t, v, rising, lsb):
    """10-90% transition time, overshoot and ±0.5 LSB settling time of an averaged step."""
    pre = t < 0
    v0 = np.median(v[pre]) if pre.sum() > 10 else v[: max(10, v.size // 20)].mean()
    v1 = np.median(v[t > t[-1] - 0.2 * (t[-1] - max(t[0], 0))])
    sw = v1 - v0
    x = (v - v0) / sw                                   # normalised 0 -> 1
    after = np.where(t >= 0)[0]
    i0 = after[0] if after.size else 0
    i10 = i0 + np.argmax(x[i0:] >= 0.1)
    i90 = i0 + np.argmax(x[i0:] >= 0.9)

    def interp(i, lvl):
        if i == 0:
            return t[0]
        return t[i - 1] + (lvl - x[i - 1]) * (t[i] - t[i - 1]) / (x[i] - x[i - 1])

    t10, t90 = interp(i10, 0.1), interp(i90, 0.9)
    overshoot = (np.max(x[i0:]) - 1.0) * 100
    outside = np.where(np.abs(v[i0:] - v1) > 0.5 * lsb)[0]
    t_settle = (t[i0 + outside[-1]] - t10) if outside.size else 0.0
    return dict(rising=rising, v_start=v0, v_end=v1, t_10_90_s=t90 - t10,
                slew_v_per_s=0.8 * sw / (t90 - t10) if t90 > t10 else float("nan"),
                overshoot_pct=overshoot, settle_half_lsb_s=t_settle, t10=t10)


def _find_transition(t, v, t_expect, search=20e-6):
    """
    Index where the trace first leaves its starting level (the glitch may go either
    way). Levels and noise come from this capture, not the static test, and the search
    is limited to +-`search` around the expected time.
    """
    k = max(1, int(round(200e-9 / (t[1] - t[0]))))      # 200 ns boxcar
    sm = np.convolve(v, np.ones(k) / k, mode="same")
    base = (t > t[0] + 2 * k * (t[1] - t[0])) & (t < t_expect - search)
    end = t > t[-1] - 30e-6
    if base.sum() < 10 or end.sum() < 10:
        return None
    va, vb = np.median(sm[base]), np.median(sm[end])
    noise = sm[base].std()
    thr = max(0.5 * abs(vb - va), 8 * noise)
    idx = np.where((np.abs(sm - va) > thr) & (t > t_expect - search) & (t < t_expect + search))[0]
    return idx[0] if idx.size else None


# ── tests ─────────────────────────────────────────────────────────────────────

def test_static(scope, board, results_dir):
    """Staircase 0..255: transfer function, DNL, INL, monotonicity."""
    step = STEP_US * 1e-6
    gap = GAP_US * 1e-6
    period = gap + (NCODES - 1) * step
    print(f"\n  staircase: code 0 for {GAP_US} us, codes 1..255 for {STEP_US} us each, "
          f"period {period*1e3:.1f} ms, {AVERAGES} averages")
    _board_start(f"ramp({STEP_US}, {GAP_US}, {CLOCK_HZ})")

    # trigger on the 255 -> 0 drop; holdoff skips the rest of the ramp
    scope.setup_channel(4.0, 1.65)
    scope.window(-0.5e-3, period + 0.5e-3)
    scope.edge_trigger(level=0.5 * VAPWR, slope="NEGative", holdoff=0.8 * period)
    scope.acquire(AVERAGES)
    t, v = scope.capture(points=1_000_000)
    np.savez_compressed(results_dir / "static_raw.npz", t=t, v=v)

    # code c is on the output from start(c) to start(c)+len(c); use 40..90% of each
    # step (RP2040 deadline jitter is ~10 us; this also skips the settling transient)
    starts = np.array([0.0] + [gap + (c - 1) * step for c in range(1, NCODES)])
    lens = np.array([gap] + [step] * (NCODES - 1))
    level = np.zeros(NCODES)
    noise = np.zeros(NCODES)
    drift = np.zeros(NCODES)
    for c in range(NCODES):
        a, b = starts[c] + 0.4 * lens[c], starts[c] + 0.9 * lens[c]
        m = (t >= a) & (t < b)
        if m.sum() < 20:
            pytest.fail(f"code {c}: only {m.sum()} samples in window - capture too short?")
        seg = v[m]
        level[c] = seg.mean()
        noise[c] = seg.std()
        h = seg.size // 2
        drift[c] = seg[h:].mean() - seg[:h].mean()      # still settling if this is large

    v0, vfs = level[0], level[-1]
    lsb = (vfs - v0) / (NCODES - 1)
    steps = np.diff(level)
    dnl = steps / lsb - 1.0                               # dnl[k]: transition k -> k+1
    codes = np.arange(NCODES)
    inl = (level - (v0 + codes * lsb)) / lsb              # endpoint INL
    fit = np.polyfit(codes, level, 1)
    inl_bf = (level - np.polyval(fit, codes)) / lsb       # best-fit INL
    nonmono = [(int(k), int(k + 1), float(steps[k] * 1e3), float(steps[k] / lsb))
               for k in np.where(steps <= 0)[0]]
    ideal_fs = _ideal_v(NCODES - 1)

    summary = dict(
        offset_v=float(v0), full_scale_v=float(vfs), ideal_full_scale_v=ideal_fs,
        gain_error_pct=float((vfs - v0) / ideal_fs * 100 - 100),
        lsb_v=float(lsb), ideal_lsb_v=VAPWR / NCODES,
        dnl_min=float(dnl.min()), dnl_min_at=f"{int(dnl.argmin())}->{int(dnl.argmin()) + 1}",
        dnl_max=float(dnl.max()), dnl_max_at=f"{int(dnl.argmax())}->{int(dnl.argmax()) + 1}",
        inl_endpoint_max=float(np.abs(inl).max()), inl_endpoint_max_at=int(np.abs(inl).argmax()),
        inl_bestfit_max=float(np.abs(inl_bf).max()),
        monotonic=not nonmono, non_monotonic=nonmono,
        noise_rms_v=float(np.median(noise)),
        max_settling_drift_lsb=float(np.abs(drift[1:]).max() / lsb),
        major_carries={f"{k}->{k+1}": dict(step_mv=float(steps[k] * 1e3), dnl=float(dnl[k]))
                       for k in (15, 31, 63, 127, 191)},
    )
    _static.update(summary)
    _static["levels"] = level

    print(f"  offset (code 0)      {v0*1e3:8.2f} mV")
    print(f"  full scale (255)     {vfs:8.4f} V   (ideal {ideal_fs:.4f} V @ VAPWR={VAPWR} V)")
    print(f"  gain error           {summary['gain_error_pct']:+8.2f} %")
    print(f"  LSB                  {lsb*1e3:8.3f} mV  (ideal {VAPWR/NCODES*1e3:.3f} mV)")
    print(f"  DNL                  {dnl.min():+.3f} @ {summary['dnl_min_at']}  "
          f"/ {dnl.max():+.3f} @ {summary['dnl_max_at']} LSB")
    print(f"  INL endpoint         {np.abs(inl).max():.3f} LSB @ code {summary['inl_endpoint_max_at']}"
          f"   best-fit {np.abs(inl_bf).max():.3f} LSB")
    print(f"  noise (rms/code)     {np.median(noise)*1e3:8.3f} mV   ({np.median(noise)/lsb:.3f} LSB)")
    print(f"  settling drift       {summary['max_settling_drift_lsb']:.3f} LSB max within a step")
    for k, d in summary["major_carries"].items():
        print(f"  carry {k:>8}       {d['step_mv']:+8.2f} mV   DNL {d['dnl']:+.3f}")
    if nonmono:
        print(f"  NON-MONOTONIC at {len(nonmono)} transition(s):")
        for a, b, mv, l in nonmono:
            print(f"     {a:3d} -> {b:3d}: {mv:+.2f} mV ({l:+.2f} LSB)")
    else:
        print("  monotonic: yes")

    with open(results_dir / "static.csv", "w") as f:
        f.write("code,v,ideal_v,noise_v,dnl_lsb,inl_endpoint_lsb,inl_bestfit_lsb\n")
        for c in range(NCODES):
            d = dnl[c] if c < NCODES - 1 else float("nan")
            f.write(f"{c},{level[c]:.6f},{_ideal_v(c):.6f},{noise[c]:.6f},{d:.4f},"
                    f"{inl[c]:.4f},{inl_bf[c]:.4f}\n")
    with open(results_dir / "static.json", "w") as f:
        json.dump(summary, f, indent=2)

    plt = _plt()
    fig, ax = plt.subplots(4, 1, figsize=(10, 13))
    ax[0].plot(t * 1e3, v, lw=0.5)
    ax[0].set(title="Captured staircase (scope averaged)", xlabel="ms", ylabel="V")
    ax[1].plot(codes, level, ".", ms=3, label="measured")
    ax[1].plot(codes, [_ideal_v(c) for c in codes], lw=0.8, label=f"ideal ({VAPWR} V ref)")
    ax[1].set(title="Transfer function", xlabel="code", ylabel="V")
    ax[1].legend()
    ax[2].bar(codes[:-1] + 0.5, dnl, width=0.8)
    ax[2].axhline(-1, color="r", lw=0.8, ls="--")
    ax[2].set(title="DNL (bar at k+0.5 = transition k->k+1; below -1 = non-monotonic)",
              xlabel="code", ylabel="LSB")
    ax[3].plot(codes, inl, label="endpoint")
    ax[3].plot(codes, inl_bf, label="best fit")
    ax[3].set(title="INL", xlabel="code", ylabel="LSB")
    ax[3].legend()
    for a in ax:
        a.grid(alpha=0.3)
    fig.tight_layout()
    fig.savefig(results_dir / "static.png", dpi=120)
    plt.close(fig)

    problems = []
    if nonmono:
        problems.append("not monotonic at " +
                        ", ".join(f"{a}->{b} ({l:+.2f} LSB)" for a, b, _, l in nonmono))
    if np.abs(dnl).max() > DNL_LIMIT:
        problems.append(f"|DNL| {np.abs(dnl).max():.2f} > {DNL_LIMIT} LSB")
    if np.abs(inl).max() > INL_LIMIT:
        problems.append(f"|INL| {np.abs(inl).max():.2f} > {INL_LIMIT} LSB")
    assert not problems, "; ".join(problems)


@pytest.mark.parametrize("rising", [True, False], ids=["rise", "fall"])
def test_full_scale_step(scope, board, results_dir, rising):
    """0 <-> 255 step: transition time, overshoot, settling to ±0.5 LSB."""
    lsb = _lsb()
    hold = STEP_HOLD_US * 1e-6
    _play([(0, STEP_HOLD_US), (255, STEP_HOLD_US)])
    scope.setup_channel(4.0, 1.65)
    scope.edge_trigger(level=0.5 * VAPWR, slope="POSitive" if rising else "NEGative")
    scope.acquire(AVERAGES)

    # wide window first: settling; then zoom in on the edge for the transition time
    scope.window(-0.1 * hold, 0.9 * hold)
    t, v = scope.capture(points=1_000_000)
    wide = _step_metrics(t, v, rising, lsb)
    tr = wide["t_10_90_s"]
    zoom_span = max(40 * tr, 200e-9)
    scope.window(-0.3 * zoom_span, 0.7 * zoom_span)
    tz, vz = scope.capture(points=200_000)
    # the zoomed window is too short for the final value; use the wide capture's levels
    zm = _step_metrics(np.concatenate([tz, [t[-1]]]), np.concatenate([vz, [wide["v_end"]]]),
                       rising, lsb)
    m = dict(wide, t_10_90_s=zm["t_10_90_s"], slew_v_per_s=zm["slew_v_per_s"],
             overshoot_pct=max(zm["overshoot_pct"], wide["overshoot_pct"]))
    name = "rise" if rising else "fall"
    print(f"\n  {name}: {m['v_start']:.3f} V -> {m['v_end']:.3f} V   "
          f"10-90% {m['t_10_90_s']*1e9:.1f} ns   slew {m['slew_v_per_s']/1e6:.1f} V/us   "
          f"overshoot {m['overshoot_pct']:.1f} %   settle ±0.5 LSB {m['settle_half_lsb_s']*1e6:.2f} us")

    with open(results_dir / f"step_{name}.json", "w") as f:
        json.dump({k: (float(x) if isinstance(x, (np.floating, float)) else x)
                   for k, x in m.items()}, f, indent=2)
    plt = _plt()
    fig, ax = plt.subplots(2, 1, figsize=(10, 7))
    ax[0].plot(t * 1e6, v, lw=0.6)
    for s in (+1, -1):
        ax[0].axhline(m["v_end"] + s * 0.5 * lsb, color="r", lw=0.5, ls="--")
    ax[0].set(title=f"Full-scale {name} (±0.5 LSB band)", xlabel="us", ylabel="V")
    ax[1].plot(tz * 1e9, vz, lw=0.8)
    ax[1].set(title=f"{name}: zoom, 10-90% = {m['t_10_90_s']*1e9:.1f} ns", xlabel="ns", ylabel="V")
    for a in ax:
        a.grid(alpha=0.3)
    fig.tight_layout()
    fig.savefig(results_dir / f"step_{name}.png", dpi=120)
    plt.close(fig)

    # fast edge then a slow exponential tail is the classic signature of an
    # under-compensated 10x passive probe - check probe comp before blaming the DAC
    i_fast = np.argmin(np.abs(t - wide["t10"] - 5 * m["t_10_90_s"]))
    tail_pct = abs(v[i_fast] - m["v_end"]) / abs(m["v_end"] - m["v_start"]) * 100
    m["tail_after_5x_tr_pct"] = float(tail_pct)
    print(f"  residual 5x(10-90%) after the edge: {tail_pct:.1f} % of the step"
          + ("   <- slow tail: check probe compensation" if tail_pct > 2 else ""))
    with open(results_dir / f"step_{name}.json", "w") as f:
        json.dump({k: (float(x) if isinstance(x, (np.floating, float)) else x)
                   for k, x in m.items()}, f, indent=2)
    assert m["settle_half_lsb_s"] < 0.9 * hold, "output never settled to ±0.5 LSB within the hold time"


@pytest.mark.parametrize("a,b", CARRY_PAIRS, ids=[f"{a}to{b}" for a, b in CARRY_PAIRS])
def test_carry_glitch(scope, board, results_dir, a, b):
    """
    Code transition a -> b: glitch peak / impulse and settling. Sequence is
    0 -> a -> b (CARRY_HOLD_US each); the scope triggers on the clean 0 -> a edge and
    the a -> b transition is CARRY_HOLD_US later. Single shots are aligned on the
    transition and averaged on the host (removes the RP2040's ~us timing jitter).
    """
    lsb = _lsb()
    levels = _static.get("levels")
    va = levels[a] if levels is not None else _ideal_v(a)
    hold = CARRY_HOLD_US * 1e-6
    _play([(0, CARRY_HOLD_US), (a, CARRY_HOLD_US), (b, CARRY_HOLD_US)])
    scope.setup_channel(4.0, 1.65)
    scope.edge_trigger(level=0.5 * va, slope="POSitive")
    scope.acquire(1)
    pre, post = 30e-6, 90e-6
    scope.window(hold - pre, hold + post)

    traces = []
    t_found = []
    for _ in range(CARRY_CAPTURES):
        t, v = scope.capture(points=100_000)
        i = _find_transition(t, v, hold)
        if i is None:
            continue
        t_found.append(t[i])
        traces.append((t - t[i], v))
    assert traces, f"no {a}->{b} transition found in {CARRY_CAPTURES} captures"
    jitter = np.std(t_found)
    print(f"  transition found in {len(traces)}/{CARRY_CAPTURES} shots, "
          f"at {np.mean(t_found)*1e6:.2f} us after trigger (+-{jitter*1e6:.2f} us)")

    dt = traces[0][0][1] - traces[0][0][0]
    trap = getattr(np, "trapezoid", None) or np.trapz
    k = max(1, int(round(20e-9 / dt)))                   # 20 ns boxcar vs scope noise

    # per-shot glitch metrics (glitches are ~100s of ns wide; averaging shots
    # aligned only to ~tens of ns would smear the peak)
    peaks, impulses = [], []
    for tt, vv in traces:
        sm = np.convolve(vv, np.ones(k) / k, mode="same")
        va_s = np.median(sm[(tt < -2e-6) & (tt > tt[0] + 1e-6)])
        vb_s = np.median(sm[tt > tt[-1] - 20e-6])
        lo_b, hi_b = min(va_s, vb_s), max(va_s, vb_s)
        g = (tt >= -0.3e-6) & (tt < 3e-6)
        ex = np.where(sm[g] > hi_b, sm[g] - hi_b, np.where(sm[g] < lo_b, sm[g] - lo_b, 0.0))
        peaks.append(ex[np.argmax(np.abs(ex))])
        w = (tt >= -0.3e-6) & (tt < 5e-6)
        impulses.append(trap(sm[w] - np.where(tt[w] < 0, va_s, vb_s), tt[w]))
    peaks = np.array(peaks)
    impulses = np.array(impulses)
    worst = peaks[np.argmax(np.abs(peaks))]
    # shots whose glitch differs a lot from the typical one: usually the RP2040 write
    # landing near a clk edge, so r2r_out latches a mixed code for one clock (input
    # skew through the TT mux) - an input-sampling effect, not the R2R ladder itself
    n_outlier = int(np.sum(np.abs(peaks - np.median(peaks)) > 4 * lsb))

    # average of the aligned shots: levels and settling
    lo, hi = -20e-6, 80e-6
    tg = np.arange(lo, hi, dt)
    avg = np.mean([np.interp(tg, tt, vv) for tt, vv in traces], axis=0)
    va_m = avg[tg < -2e-6].mean()
    vb_m = avg[tg > hi - 20e-6].mean()
    band_lo, band_hi = min(va_m, vb_m), max(va_m, vb_m)
    after = tg >= 0
    avg_s = np.convolve(avg, np.ones(k) / k, mode="same")
    outside = np.where(np.abs(avg_s[after][:-k] - vb_m) > 0.5 * lsb)[0]
    t_settle = tg[after][outside[-1]] if outside.size else 0.0

    m = dict(a=a, b=b, captures=len(traces), v_a=float(va_m), v_b=float(vb_m),
             step_mv=float((vb_m - va_m) * 1e3), step_lsb=float((vb_m - va_m) / lsb),
             glitch_peak_median_mv=float(np.median(peaks) * 1e3),
             glitch_peak_median_lsb=float(np.median(peaks) / lsb),
             glitch_peak_worst_mv=float(worst * 1e3), glitch_peak_worst_lsb=float(worst / lsb),
             glitch_impulse_median_nVs=float(np.median(impulses) * 1e9),
             settle_half_lsb_us=float(t_settle * 1e6),
             outlier_shots=n_outlier,
             transition_jitter_us=float(jitter * 1e6))
    print(f"  {a:3d} -> {b:3d}: step {m['step_mv']:+6.2f} mV ({m['step_lsb']:+.2f} LSB)   "
          f"glitch median {m['glitch_peak_median_mv']:+7.2f} mV ({m['glitch_peak_median_lsb']:+.2f} LSB)  "
          f"worst {m['glitch_peak_worst_mv']:+7.2f} mV   impulse {m['glitch_impulse_median_nVs']:+.2f} nV.s   "
          f"settle {m['settle_half_lsb_us']:.2f} us")
    if n_outlier:
        print(f"           {n_outlier}/{len(traces)} shots had an atypical glitch "
              f"(likely a mixed code latched for one clk - see test docstring)")

    with open(results_dir / f"carry_{a}_{b}.json", "w") as f:
        json.dump(m, f, indent=2)
    plt = _plt()
    fig, ax = plt.subplots(2, 1, figsize=(10, 7))
    for axi, (x0, x1) in zip(ax, ((lo, hi), (-1e-6, 3e-6))):
        for tt, vv in traces:
            sel = (tt >= x0) & (tt < x1)
            sm = np.convolve(vv, np.ones(k) / k, mode="same")
            axi.plot(tt[sel] * 1e6, (sm if x1 - x0 < 10e-6 else vv)[sel] * 1e3,
                     lw=0.4, alpha=0.4, color="grey")
        sel = (tg >= x0) & (tg < x1)
        axi.plot(tg[sel] * 1e6, avg[sel] * 1e3, lw=1.0, label=f"average of {len(traces)}")
        for y, lbl in ((va_m, f"code {a}"), (vb_m, f"code {b}")):
            axi.axhline(y * 1e3, ls="--", lw=0.6)
            axi.text(x1 * 1e6, y * 1e3, lbl, va="bottom", ha="right", fontsize=8)
        axi.grid(alpha=0.3)
        axi.legend(loc="lower right")
    ax[0].set(title=f"{a} -> {b} transition", xlabel="us (0 = transition)", ylabel="mV")
    ax[1].set(title=f"zoom: grey = individual shots (20 ns smoothed); "
                    f"glitch median {m['glitch_peak_median_mv']:+.1f} mV, worst {m['glitch_peak_worst_mv']:+.1f} mV",
              xlabel="us", ylabel="mV")
    fig.tight_layout()
    fig.savefig(results_dir / f"carry_{a}_{b}.png", dpi=120)
    plt.close(fig)

    # characterisation only: the static test owns the pass/fail on monotonicity
    assert len(traces) >= CARRY_CAPTURES // 2, "too few captures found the transition"
