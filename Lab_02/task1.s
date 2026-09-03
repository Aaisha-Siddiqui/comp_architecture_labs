main:
    li x19, 2
    li x22, 5
    li x23, 3
    li x20, 2
    li x12, 1
    li x24, 4
    li x25, 1
    bne x22, x23, Else
    add x19, x20, x12
    beq x0, x0, Exit
Else: sub x19, x20, x12
Loop: slli x10, x22, 2
    add x10, x10, x25
    lw x9, 0(x10)
    bne x9, x24, Exit
    addi x22, x22, 1
    beq x0, x0, Loop
Exit:
end:
    j end   

#code had been adjusted to make it runnable for testing
#for accurate assembly value outputs(instruction values) chunks not present in listing 3 and 4 had to be commented out.
