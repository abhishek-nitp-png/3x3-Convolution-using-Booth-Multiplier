# 3x3 Convolution using Booth Multiplier

## Overview
This project implements a 3x3 convolution architecture in Verilog HDL using Booth multiplication for efficient signed arithmetic operations.

## Features
- Booth multiplier implementation
- 3x3 convolution architecture
- Carry Look Ahead (CLA) adders
- Modular RTL design
- Testbench verification
- Synthesizable Verilog code

## Project Structure

```text
convolution_using_booth_mul/
│
├── booth_mul.v
├── CLA_4bit.v
├── CLA_17bit.v
├── Conv_Controller.v
├── ...
```

## Design Flow
1. Designed individual arithmetic modules.
2. Implemented 8-bit MAC functionality.
3. Integrated Booth multiplier into convolution architecture.
4. Verified functionality using simulation and waveform analysis.

## Tools Used
- Verilog HDL
- ModelSim / Vivado
- GTKWave

## Future Improvements
- Pipelined architecture
- FPGA implementation
- CNN accelerator integration

## Author
Abhishek Kumar  
ECE, NIT Patna
