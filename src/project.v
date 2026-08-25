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
  wire done; // Whole byte that's been sent to the controller 
  wire reset; // Reset signal


  // Mapping input wires
  assign spi_cs_n = ui_in[0];
  assign spi_clk = ui_in[1];
  assign spi_miso = ui_in[2];
  assign cpol = ui_in[3];
  assign cpha = ui_in[4];
  assign reset = ui_in[5];

  // Mapping output wires
  assign ui_out[0] = spi_mosi;
  assign ui_out[1] = done;


  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0; assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
