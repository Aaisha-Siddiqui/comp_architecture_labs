# Lab 10 — Task 1: FSM control flow

## States and transitions

- **WAIT / wait_state:** Check the reset-button register first. If reset is pressed, clear LEDs and remain waiting. Otherwise read switches.
- **READ SWITCHES / read_sw:** If the switch value is zero, go back to WAIT. If nonzero, display the value and call the countdown routine.
- **COUNTDOWN / count_loop:** Display the current counter. If it is zero, finish. Otherwise run the delay routine.
- **RESET DURING COUNTDOWN:** The delay routine returns 1 when reset is pressed. The countdown sets the counter to zero; the next loop pass clears LEDs and finishes.
- **COUNT NEXT:** If reset was not pressed, decrement the counter and repeat.
- **RETURN:** Restore saved registers and return to WAIT.

## Flowchart

Start → Initialize stack and addresses → Clear LEDs → WAIT: read reset button
- Reset pressed? **Yes** → Clear LEDs → WAIT
- Reset pressed? **No** → Read switches
  - Switches = 0? **Yes** → WAIT
  - Switches nonzero → Display switch value → Call COUNTDOWN
    - Counter = 0? **Yes** → Clear LEDs → Return to WAIT
    - Counter nonzero → Call DELAY
      - Reset pressed? **Yes** → Set counter to 0 → repeat COUNT_LOOP → Clear LEDs → Return to WAIT
      - Reset pressed? **No** → Decrement counter → repeat COUNT_LOOP

## Address assumptions

- LEDs: `0x200`
- Switches: `0x300`
- Reset-button status: `0x304`, bit 0

The reset register at `0x304` must be implemented in the hardware decoder. In the Lab 8 address map, `0x304` is within the existing switch region; it will not independently report a button unless the decoder/interface is extended.
