/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_kaipereira_spicontroller (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire spi_cs_n; // _n postfixes to denote an active-low signal because the microcontroller wants to communicate when it's low
  wire spi_clk;
  wire spi_miso; // Master in, slave out
  wire spi_mosi; // Master out, slave in

  wire cpol; // Clock polarity
  wire cpha; // Clock phase
  wire reset; // Reset signal
  wire done; // Signal once a byte has been received
  wire write_protect; // Prevent accidental writes by pulling low
  wire hold; // Pause communication without CS important so you don't stop the master clock or deselect the slave

  assign uio_oe[0] = 1'b0;
  assign uio_oe[1] = 1'b1;
  assign uio_oe[3:2] = 2'b00;
  assign uio_oe[4] = 1'b1;
  assign uio_oe[7:5] = 3'b000;

  assign spi_cs_n = uio_in[0];
  assign spi_mosi = uio_out[1];
  assign spi_miso = uio_in[2];
  assign spi_clk = uio_in[3];
  assign uio_out[4] = done;
  assign reset = uio_in[5];
  assign uio_in[6] = write_protect;
  assign hold = uio_in[7];

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
