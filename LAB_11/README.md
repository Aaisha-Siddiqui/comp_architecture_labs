# Lab 11 — Single-Cycle RISC-V Processor

The files in this folder implement the two tasks from pages 116–118 of the Computer Architecture Lab manual.

## Task 1
- `sources_1/ProgramCounter.v`
- `sources_1/pcAdder.v`
- `sources_1/branchAdder.v`
- `sources_1/mux2.v`
- `sources_1/immGen.v`
- `sim_1/Task1_tb.v`

## Task 2
- `sources_1/TopLevelProcessor.v`
- `sources_1/instructionMemory.v`
- `sim_1/TopLevelProcessor_tb.v`

## Existing modules to add to Vivado
Add the Lab 6 ALU files, Lab 7 `RegisterFile.v`, and Lab 9 `ControlPath.v`, `MainControl.v`, and `ALUControl.v` to the project.

## Instruction memory
`instructionMemory.v` loads `fsm_program.mem` with `$readmemh`. Keep this file in the simulator's working directory or adjust the path in the module. `words.txt` contains the Lab 10 machine-code words and `makemem.py` converts those words into the byte-oriented memory file format.

## Important checks before FPGA programming
- The ALU and ControlPath are reused as they are in the existing repository. Verify that all operation encodings needed by the Lab 10 program work together.
- The Lab 8 address decoder selects RAM for 0x000–0x1FF, LEDs for 0x200–0x2FF, and switches for 0x300–0x3FF. The Lab 10 code addresses reset at 0x304; this top module maps that read to the physical switch bus because the current Lab 8 switch interface does not provide a separate reset-button input.
- Run both testbenches in Vivado and inspect PC, instruction, ALU result, memory writes and LEDs before hardware testing.
- Task 2 deliverables also include the datapath schematic, utilization report and timing analysis report.
