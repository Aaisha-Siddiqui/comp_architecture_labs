.text
_start:
    addi sp,  x0, 0x1F0
    addi x18, x0, 0x200
    addi x19, x0, 0x300
    addi x20, x0, 0x304
    sw   x0,  0(x18)

wait_state:
    lw   x10, 0(x20)
    beq  x10, x0, read_sw
    sw   x0,  0(x18)
    jal  x0,  wait_state

read_sw:
    lw   x10, 0(x19)
    beq  x10, x0, wait_state
    sw   x10, 0(x18)
    jal  x1,  countdown
    jal  x0,  wait_state

countdown:
    addi sp, sp, -8
    sw   x1, 4(sp)
    sw   x8, 0(sp)
    addi x8, x10, 0

count_loop:
    sw   x8, 0(x18)
    beq  x8, x0, count_done
    jal  x1, delay
    beq  x10, x0, count_next
    addi x8, x0, 0
    jal  x0, count_loop

count_next:
    addi x8, x8, -1
    jal  x0, count_loop

count_done:
    lw   x8, 0(sp)
    lw   x1, 4(sp)
    addi sp, sp, 8
    jalr x0, 0(x1)

delay:
    addi x5, x0, 977
    addi x6, x0, 10
    sll  x5, x5, x6

delay_loop:
    lw   x7, 0(x20)
    beq  x7, x0, delay_cont
    addi x10, x0, 1
    jalr x0, 0(x1)

delay_cont:
    addi x5, x5, -1
    beq  x5, x0, delay_end
    jal  x0, delay_loop

delay_end:
    addi x10, x0, 0
    jalr x0, 0(x1)
