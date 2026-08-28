# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, Timer


async def sck_clock(dut, pin, period_ns):
    while True:
        dut.uio_in.value = int(dut.uio_in.value) | (1 << pin);
        await Timer(period_ns / 2, unit="ns");
        dut.uio_in.value = int(dut.uio_in.value) & ~(1 << pin);
        await Timer(period_ns / 2, unit="ns");

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 0.0625 us (16 MHz)
    clock = Clock(dut.clk, 62.5, unit="ns")

    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    cocotb.start_soon(sck_clock(dut, 3, 250));

    dut._log.info("Test project behavior")

    # Wait for one clock cycle to see the output values
    await ClockCycles(dut.clk, 50)

    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    # assert dut.uo_out.value == 50

    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
