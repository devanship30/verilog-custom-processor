# Verilog Custom Processor
This project implements a simple custom processor in Verilog HDL with:
- 32 General Purpose Registers (GPRs)
- Instruction memory and data memory
- Arithmetic, logical, load/store, and jump operations
- Status flags (zero, sign, carry, overflow)
- Testbench for functional verification

***

## Repository Structure

- 'rtl/'   : Contains the synthesizable Verilog RTL (`top.v`)
- `tb/`    : Contains the testbench (`top_tb.v`) for simulation
- `mem/`   : Contains program memory files (`program_1.mem`, `program_2.mem`) for different instruction programs

***
