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
- `mem/program_1.mem` : Program image 1
- `mem/program_2.mem` : Program image 2

***

## Processor Architecture

The processor is implemented in a single top-level Verilog module (`top.v`). The main components are:
- **Instruction Register (IR):** Holds the current instruction.
- **General Purpose Registers (GPR[31:0]):** 32 registers to store operands and results.
- **Special GPR (SGPR):** Stores the upper 16 bits of multiplication results.
- **Program Counter (PC):** Tracks the instruction memory address.
- **Instruction Memory (`inst_mem`):** Holds the program instructions.
- **Data Memory (`data_mem`):** Stores runtime data.
- **Status Flags:** Zero, Sign, Carry, Overflow.
- **Finite State Machine (FSM):** Manages fetch, decode, execute, and halt states.

***

## Instruction Set and Program Memory

The processor supports the following operations:

### Arithmetic:
- `movsgpr` : Move value from SGPR to GPR
- `mov`     : Move value from another GPR or immediate
- `add`     : Add two registers or register + immediate
- `sub`     : Subtract two registers or register - immediate
- `mul`     : Multiply two registers or register * immediate (upper 16 bits stored in SGPR)

### Logical:
- `ror`, `rand`, `rxor`, `rxnor`, `rnand`, `rnor`, `rnot` (operations with registers or immediate)

### Load/Store:
- `storereg`, `storedin`, `senddout`, `sendreg` 

### Jump/Branch:
- `jump`, `jcarry`, `jnocarry`, `jsign`, `jnosign`, `jzero`, `jnozero`, `joverflow`, `jnooverflow`

### Halt:
- `halt` stops the processor until reset

### Program Memory:
- Located in `mem/`
- Each `.mem` file contains instructions for one program:
  - `program_1.mem`
  - `program_2.mem`
- Only one program is loaded at a time via `$readmemb` in `top.v`.

***

## Testbench (`top_tb.v`)

The testbench verifies the processor functionality:

- Generates a clock (`clk`) with 10 ns period
- Applies system reset (`sys_rst`)
- Provides input data (`din`) to the processor
- Observes output (`dout`)
- Simulates the processor for a specified duration (#1800 ns) and stops

***

## Processor FSM

The processor uses a Finite State Machine with 6 states:

1. **idle**          : Wait for reset
2. **fetch_inst**    : Fetch instruction from `inst_mem`
3. **dec_exec_inst** : Decode and execute instruction
4. **delay_next_inst**: Introduce small delay for proper operation
5. **next_inst**     : Update PC for next instruction
6. **sense_halt**    : Check for `halt` instruction and stop execution

***

## Simulation Instructions

1. Open the project in your preferred simulator (ModelSim, Vivado, etc.)
2. Select the top-level testbench `top_tb.v`
3. Ensure the desired program memory file is active in `top.v` (`$readmemb("program_mem.mem", inst_mem);`)
4. Compile and run the simulation
5. Observe waveforms or console outputs to verify processor operations

***

## Key Learnings

- Verilog RTL design and module integration
- Instruction fetch, decode, and execute flow
- Finite State Machine design for processor control
- Implementing custom instruction set with arithmetic, logical, jump, and memory operations
- Writing structured testbenches for functional verification
- Handling flags: zero, sign, carry, overflow
- Using `$readmemb` to load program memory for simulation
