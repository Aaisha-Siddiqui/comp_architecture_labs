# Lab 10 — State-Based Control Flow Using RISC-V Assembly

## Files
- `Task1_FSM.md` — FSM states and control flow.
- `Task2_FSM.s` — RISC-V assembly using the provided WAIT, COUNTDOWN, and DELAY logic.
- `instructionMemory.v` — byte-array instruction ROM that outputs one 32-bit instruction.
- `fsm_machine_code.hex` — machine-code bytes for the assembly program, stored little-endian.

## Memory map assumed
- LEDs (write): `0x200`
- Switches (read): `0x300`
- Reset button (read, bit 0): `0x304`
- Stack pointer starts at `0x1F0`

## Important hardware notes
The Lab 8 decoder maps the `0x300–0x3FF` address region to the switch interface. Therefore, `0x304` will not act as an independent reset register unless the decoder and input interface are extended to return the reset-button state at that address.

The stack pointer location must be backed by writable data RAM. The instruction memory treats `instAddress` as a byte address and returns the four bytes beginning at that address, in little-endian order. The processor PC should point to byte addresses aligned to four bytes and advance by 4 for each instruction.

The delay loop is an approximate software delay. Its actual time depends on the processor's instruction-cycle timing.
