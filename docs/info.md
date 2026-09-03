<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

My SPI slave is quite simple...

First, I use a triple flip-flop synchronizer to align the external SCLK clock domain, with the internal CLK clock domain and to also prevent metastability.

Next, I use the internal CLK domain to sample the falling and rising edges of the synchronized SCLK domain and then I shift a full byte of MOSI into a byte buffer on the rising edges, and then once that's complete, I'll shift it out onto MISO on the falling edges.

## How to test

To test the project, you'll just want to connect up some probes to the SPI MOSI and MISO signals and just check to see if the MOSI signals are being echoed onto the MISO line.
