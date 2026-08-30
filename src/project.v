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
  wire spi_sclk; // This is the clock signal coming from the master
  wire spi_miso; // Master in, slave out
  wire spi_mosi; // Master out, slave in
  wire reset; // Reset signal
  wire done; // Signal once a byte has been received
  wire write_protect; // Prevent accidental writes by pulling low
  wire hold; // Pause communication without CS important so you don't stop the master clock or deselect the slave

  wire cpol = 1'b0; // Clock polarity
  wire cpha = 1'b0; // Clock phase

  assign uio_oe[7:0] = 8'b0001_0100;

  assign spi_cs_n = uio_in[0];
  assign spi_mosi = uio_in[1];
  assign uio_out[2] = spi_miso;
  assign spi_sclk = uio_in[3];
  assign uio_out[4] = done;
  assign reset = uio_in[5];
  assign write_protect = uio_in[6] ;
  assign hold = uio_in[7];

  // Shift registers for the stable SCLK and CS signals
  reg [1:0] sclk_reg;
  reg [1:0] cs_reg;
  reg [1:0] mosi_reg;

  // Sample on each clock edge or whenever RST changes
  // Implement CPOL and CPHA still
  always @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin // if there's a reset, put everything into it's known state
      sclk_reg <= 2'b00;
      cs_reg <= 2'b11;
      mosi_reg <= 2'b00;
    end else begin
      sclk_reg <= {sclk_reg[0], spi_sclk};
      cs_reg <= {cs_reg[0], spi_cs_n};
      mosi_reg <= {mosi_reg[0], spi_mosi};
    end
  end

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, 1'b0};

endmodule
