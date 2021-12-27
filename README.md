# FPGA implementation of 2D-DCT using Verilog

The discrete cosine transform is a fast transform that takes a input and transforms it into linear combination of weighted basis function, these basis functions are commonly the frequency, like sine waves.

It is widely used and robust method for image compression, it has excellent energy compaction for highly correlated data.

The DCT basis functions are for size 8 x 8 .The mapping between the mathematical values and the colors (gray levels) is the same as in the DFT case.
Each basis function occupies a small square; the squares are then arranged into as 8 x 8 matrix. 


