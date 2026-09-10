main:
 # Put string y in memory
    li x11, 0x300          # y = 0x300
    li x19, 72             # 'H'
    sb x19, 0(x11)
    li x19, 69             # 'E'
    sb x19, 1(x11)
    li x19, 76             # 'L'
    sb x19, 2(x11)
    li x19, 76             # 'L'
    sb x19, 3(x11)
    li x19, 79             # 'O'
    sb x19, 4(x11)
    li x19, 0              # null character
    sb x19, 5(x11)
# Call strcpy
    li x10, 0x310          # x = destination
    li x11, 0x300          # y = source
    li sp, 0x320           # stack pointer
    jal x1, strcpy         # call strcpy
    # Program finished
    j end

# strcpy(x, y)
strcpy:
    # Save x19 on stack
    addi sp, sp, -4 # we did -4 because one reg takes 4 bytes so made space
    sw x19, 0(sp)
copy_loop:
    # Load one character from y
    lb x19, 0(x11)
    # Check for null character
    beq x19, x0, done
    # Store character into x
    sb x19, 0(x10)
    # Move to next character
    addi x10, x10, 1
    addi x11, x11, 1
    j copy_loop
done:
    # Store null character in destination
    sb x0, 0(x10)
    # Restore x19
    lw x19, 0(sp)
    addi sp, sp, 4
    # Return to main
    jalr x0, 0(x1)
end:
    j end