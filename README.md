![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# SPI Slave Device

This is my custom SPI slave ASIC I've decided to make in order to learn how to make my own chip from start to end.

It essentially receives the MOSI signal from the master controller and then just re-sends it over MISO but it was surprisingly challenging for me to make because it's my first Verilog project, but it was so much fun!

## Setup

Setting up the project is quite simple; I'd suggest installing the ![OSS CAD Suite environment](https://github.com/yosyshq/oss-cad-suite-build) which creates a virtual environment with all the tools you need to run the project, and then you can visualize the waveforms by running the GTKWave viewer:

```
cd src/test
make -B
gtkwave tb.fst tb.gtkw
```

## Inspiration

This project uses the tinytapeout skeleton which has all of the workflows to build your project and get it ready for manufacturing which I'll eventually do with some future projects!

Thanks to ![Julia Desmazes](https://essenceia.github.io/about/) for bringing me into this amazing world too :D 
