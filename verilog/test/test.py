import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles
import math

MAX_SINE_ERROR = 4

async def test_sine(dut, divider):
    # sync with the internal counter
    await FallingEdge(dut.cnt_zero)
    step_increment = (2 * math.pi) * 1 / (2**divider)
    max_error = 0
    for i in range(2**divider):
        expected_value = int(128 * (math.sin(step_increment*i)+1))
        dut._log.debug(dut.r2r_out.value.integer, expected_value)
        error = abs(dut.r2r_out.value.integer - expected_value)
        if error > max_error:
            max_error = error
        assert max_error <= MAX_SINE_ERROR
        await ClockCycles(dut.clk, 1)
    dut._log.info(f"max error {max_error}")

async def reset(dut):
    dut._log.info("reset")
    dut.n_rst.value = 0
    await ClockCycles(dut.clk, 10)
    dut.n_rst.value = 1

@cocotb.test()
async def test(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    dut.ext_data.value = 0
    dut.load_divider.value = 0
    dut.data.value = 0

    await reset(dut)

    # test external control by driving each value
    dut._log.info("starting external drive test")
    dut.ext_data.value = 1
    for i in range(2**8):
        dut.data.value = i
        await ClockCycles(dut.clk, 1)
        if i > 0:
            assert dut.r2r_out == i - 1

    # test internal generated sine
    dut._log.info("starting internal sine test")
    dut.ext_data.value = 0
    await reset(dut)
    await test_sine(dut, 8)

    # test internal generated clock with divider
    dut._log.info("starting internal sine test with divider")
    await reset(dut)
    dut.data.value = 1
    dut.load_divider.value = 1
    await ClockCycles(dut.clk, 1)
    dut.load_divider.value = 0

    await test_sine(dut, 9)


