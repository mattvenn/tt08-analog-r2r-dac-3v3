"""
MicroPython helper for the R2R DAC hardware-in-the-loop test (runs on the RP2040 demoboard).

Uploaded to the board by test_hil.py. Puts the project in external-data mode
(uio_in[0] = 1) and then plays a sequence of DAC codes on ui_in[7:0] with
deadline-locked timing (time.ticks_us), so step timing does not drift.

The SDK's tt.ui_in.value setter takes ~2ms per write, so codes are written
straight to the SIO GPIO_OUT_XOR register: all 8 bits change in one bus write
(no intermediate codes on the inputs).

ui_in pin map for the TT04-TT08 RP2040 demoboard: GPIO 9-12, 17-20.
"""
import gc
import time
import machine

PINS = (9, 10, 11, 12, 17, 18, 19, 20)   # ui_in[0..7]
SIO_GPIO_OUT = 0xd0000010
SIO_GPIO_OUT_XOR = 0xd000001c

MASK = 0
for _p in PINS:
    MASK |= 1 << _p

_tt = None


def _mask(code):
    m = 0
    for b in range(8):
        if (code >> b) & 1:
            m |= 1 << PINS[b]
    return m


def board(clock_hz=10_000_000):
    """Create the DemoBoard once, enable the project, select external data."""
    global _tt
    if _tt is None:
        gc.threshold(10000)
        from ttboard.demoboard import DemoBoard
        try:
            from ttboard.boot.demoboard_detect import DemoboardDetect
            DemoboardDetect.probe()
        except ImportError:
            pass
        from ttboard.mode import RPMode
        tt = DemoBoard()
        tt.shuttle.tt_um_mattvenn_r2r_dac_3v3.enable()
        tt.mode = RPMode.ASIC_RP_CONTROL
        tt.ui_in.value = 0
        tt.uio_oe_pico.value = 0b00000011   # RP drives uio[0] ext_data, uio[1] load_divider
        tt.uio_in.value = 0b00000001        # ext_data=1, load_divider=0
        tt.clock_project_PWM(clock_hz)      # r2r_out is registered on clk
        tt.reset_project(True)
        tt.reset_project(False)
        _tt = tt
    return _tt


def set_code(code):
    mem = machine.mem32
    mem[SIO_GPIO_OUT_XOR] = (mem[SIO_GPIO_OUT] ^ _mask(code)) & MASK


def hold(code, clock_hz=10_000_000):
    tt = board(clock_hz)
    set_code(code)
    print('HOLD', code, 'readback', tt.ui_in.value)


def play(seq, clock_hz=10_000_000):
    """Loop forever over [(code, hold_us), ...]. Stop with Ctrl-C (any mpremote connect)."""
    board(clock_hz)
    s = [(_mask(c), int(h)) for c, h in seq]
    mem = machine.mem32
    ticks = time.ticks_us
    tadd = time.ticks_add
    tdiff = time.ticks_diff
    print('PLAYING', len(s), 'steps, period_us', sum(h for _, h in s))
    gc.collect()
    gc.disable()
    try:
        t = tadd(ticks(), 1000)
        while True:
            for m, h in s:
                while tdiff(t, ticks()) > 0:
                    pass
                mem[SIO_GPIO_OUT_XOR] = (mem[SIO_GPIO_OUT] ^ m) & MASK
                t = tadd(t, h)
    finally:
        gc.enable()
        set_code(0)


def ramp(step_us=200, gap_us=2000, clock_hz=10_000_000):
    """Code 0 for gap_us, then codes 1..255 for step_us each, repeat."""
    play([(0, gap_us)] + [(c, step_us) for c in range(1, 256)], clock_hz)
