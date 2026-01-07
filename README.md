# Verilog Custom Processor

This repository contains the design and verification of a **custom processor implemented in Verilog HDL**.  
The processor executes programs loaded from instruction memory files and supports **arithmetic, logical, load/store, and control-flow operations**.

The project focuses on **RTL-level processor design**, custom instruction decoding, **FSM-based control**, and **simulation-based verification** using a dedicated testbench.

Key features of the processor include:
- 32 General Purpose Registers (GPRs)
- Instruction memory and data memory
- Arithmetic, logical, load/store, and jump instructions
- Status flag handling (zero, sign, carry, overflow)
- Program execution using external `.mem` instruction files
- Functional verification through a Verilog testbench

***

## Repository Structure

- `rtl/`   : Contains the synthesizable Verilog RTL (`top.v`)
- `tb/`    : Contains the testbench (`top_tb.v`) for simulation
- `mem/`   : Contains program memory files (`program_1.mem`, `program_2.mem`) for different instruction programs

### Files
- `rtl/top.v`      : Top-level processor RTL
- `tb/top_tb.v`    : Testbench for functional verification
- `mem/program_1.mem` : Program code 1
- `mem/program_2.mem` : Program code 2

***

## Processor Overview

The processor is implemented as a **single top-level module** (`top.v`) that integrates all major components internally.  
The design follows a **fetch → decode → execute** execution model controlled by a finite state machine (FSM).

### Major Components

- **Instruction Register (IR)**  
  Holds the currently fetched 32-bit instruction.

- **General Purpose Registers (GPR[31:0])**  
  32 registers (16-bit wide) used for operand storage and computation results.

- **Special Register (SGPR)**  
  Stores the upper 16 bits of multiplication results.

- **Instruction Memory (`inst_mem`)**  
  Holds the program instructions loaded from a `.mem` file.

- **Data Memory (`data_mem`)**  
  Used for load and store instructions.

- **Program Counter (PC)**  
  Points to the current instruction address.

- **Status Flags**
  - Zero
  - Sign
  - Carry
  - Overflow

- **Finite State Machine (FSM)**  
  Controls instruction fetch, decode, execution, and halt behavior.

***

## Instruction Format

Each instruction is 32 bits wide and uses the following fields:

- Opcode (`oper_type`)  : `IR[31:27]`
- Destination register  : `IR[26:22]`
- Source register 1     : `IR[21:17]`
- Immediate mode bit    : `IR[16]`
- Source register 2     : `IR[15:11]`
- Immediate value       : `IR[15:0]`

Immediate mode allows instructions to operate either on register values or immediate constants.

***

## Supported Instruction Set

### Arithmetic Instructions
- `movsgpr` : Move SGPR value to GPR
- `mov`     : Register or immediate move
- `add`     : Addition
- `sub`     : Subtraction
- `mul`     : Multiplication (lower 16 bits to GPR, upper 16 bits to SGPR)

### Logical Instructions
- `ror`    : OR
- `rand`   : AND
- `rxor`   : XOR
- `rxnor`  : XNOR
- `rnand`  : NAND
- `rnor`   : NOR
- `rnot`   : NOT

### Load / Store Instructions
- `storereg` : Store register value into data memory
- `storedin` : Store external input (`din`) into data memory
- `senddout` : Send data memory value to output (`dout`)
- `sendreg`  : Load data memory value into a register

### Jump and Branch Instructions
- `jump`        : Unconditional jump
- `jcarry`      : Jump if carry flag is set
- `jnocarry`    : Jump if carry flag is not set
- `jsign`       : Jump if sign flag is set
- `jnosign`     : Jump if sign flag is not set
- `jzero`       : Jump if zero flag is set
- `jnozero`     : Jump if zero flag is not set
- `joverflow`   : Jump if overflow flag is set
- `jnooverflow` : Jump if overflow flag is not set

### Halt Instruction
- `halt` : Stops program execution until system reset

***

## Program Memory (`mem/`)

The `mem/` directory contains **multiple instruction memory files**, each representing a different program.

- `program_1.mem` : Program image 1
- `program_2.mem` : Program image 2

Only **one program is loaded at a time** using `$readmemb` in the RTL.
This approach allows testing multiple programs without modifying the processor RTL.

***

## Processor FSM States

The processor execution is controlled by a Finite State Machine with the following states:

- **idle**
Initializes registers and waits for reset release.

- **fetch_inst**
Fetches instruction from instruction memory using PC.

- **dec_exec_inst**
Decodes the instruction and executes the operation.

- **delay_next_inst**
Adds a small delay between instructions.

- **next_inst**
Updates the program counter (PC).

- **sense_halt**
Detects halt instruction and stops execution if required.

***

## Testbench (`top_tb.v`)

The testbench provides functional verification for the processor.

Testbench Features
- Clock generation with a 10 ns period
- System reset initialization
- Input stimulus using din
- Observation of output using dout

Simulation runs for a fixed duration and terminates using $stop

Additional commented test cases are included in the testbench for:
- Arithmetic operations
- Logical operations
- Flag validation (zero, sign, carry, overflow)
- These demonstrate detailed verification of individual instructions.

***

## Simulation Instructions

1. Open the project in your preferred simulator (ModelSim, Vivado, etc.)
2. Select the top-level testbench `top_tb.v`
3. Ensure the desired program memory file is active in `top.v` (`$readmemb("program_mem.mem", inst_mem);`)
4. Compile and run the simulation
5. Observe waveforms or console outputs to verify processor operations

- Open the project in a Verilog simulator (Vivado, ModelSim, etc.).
- Compile the RTL file:
    rtl/top.v
- Compile the testbench:
    tb/top_tb.v
- Ensure the desired program file is present in mem/.
- Run the simulation and observe waveforms or console output.

***

## Key Learnings

- RTL design of a custom processor using Verilog HDL
- Instruction fetch, decode, and execution flow
- FSM-based control logic
- Custom instruction set implementation
- Program memory initialization using $readmemb
- Handling processor flags (zero, sign, carry, overflow)
- Writing structured testbenches for processor verification

***

## Future Improvements

- Modularizing the design (separate ALU, register file, control unit)
- Adding pipelining for performance improvement
- Expanding instruction and data memory size
- Supporting additional instructions

***
