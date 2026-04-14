# Pipelined CORDIC Algorithm Implementation

## Overview
This repository contains a high-performance, **pipelined CORDIC (Coordinate Rotation Digital Computer)** core implemented in Verilog. The design is configured for **Rotation Mode**, allowing the calculation of Sine and Cosine values for a given input angle using only shifts and additions, effectively eliminating the need for hardware multipliers.

## Key Features
* **Fully Pipelined Architecture:** Provides a new result every clock cycle once the pipeline is filled.
* **Full Quadrant Support:** Handles angles across the entire 360° range (0 to 2π) by pre-rotating input vectors based on the angle's quadrant.
* **High Precision:** * **Data Path:** 16-bit signed fixed-point.
    * **Angle Resolution:** 32-bit resolution (Full circle = 2^32 units).
* **Pre-calculated LUT:** Includes a 30-stage `atan` table for high-accuracy iterative rotations.

## Technical Specifications

### Hardware Interface
| Signal | Width | Direction | Description |
| :--- | :--- | :--- | :--- |
| `clk` | 1 | Input | System Clock |
| `x_start` | 16 | Input | Initial X-vector (typically CORDIC gain $A_n \approx 19436$) |
| `y_start` | 16 | Input | Initial Y-vector (typically 0 for sine/cosine) |
| `angle` | 32 | Input | Target rotation angle |
| `sin` | 16 | Output | Calculated Sine value ($y_n$) |
| `cos` | 16 | Output | Calculated Cosine value ($x_n$) |

### Synthesis & Implementation Results
The design has been verified using Xilinx Vivado for an Artix-7 target:
* **Logic Utilization:** 997 Slice LUTs.
* **Register Utilization:** 961 Slice Registers.
* **Timing Performance:**
    * **Worst Negative Slack (WNS):** 7.432 ns.
    * **Worst Hold Slack (WHS):** 0.131 ns.
    * **Clock Period:** 10.00 ns (100 MHz target).

## Simulation Guide

### Using ModelSim / QuestaSim
An automated `.do` script is provided to compile and run the testbench:
1. Open your simulator console.
2. Run the command: `do run_cordic.do`

### Testbench Coverage
The provided `tb.v` includes test cases for various critical angles:
* $0^\circ, 45^\circ, 60^\circ, 75^\circ,$ and $90^\circ$.

### Output Scaling
To map the fixed-point outputs into the standard range of $[-1, +1]$, each raw output must be divided by the amplitude factor $A \approx 1.647$ (or normalized according to the 16-bit scale used).

## Repository Structure
* `CORDIC.v`: Main RTL implementation.
* `tb.v`: Comprehensive testbench.
* `run_cordic.do`: Simulation automation script.
* `Constraints.xdc`: FPGA physical constraints and timing requirements.
