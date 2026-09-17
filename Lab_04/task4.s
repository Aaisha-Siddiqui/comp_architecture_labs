main:
    li sp, 0x200
    li x10, 6             # n = 6
    jal x1, fib           # Call Fibonacci
    addi x11, x10, 0      # Move result to x11
    li x10, 1             # Print integer
    ecall
    j end
fib:
    # Make stack space
    addi sp, sp, -12
    # Save return address
    sw x1, 8(sp)
    # Save n
    sw x10, 4(sp)
    beq x10, x0, base_zero  # if n == 0
    li x5, 1
    beq x10, x5, base_one  # if n == 1
    # Calculate fib(n-1)
    addi x10, x10, -1
    jal x1, fib
    # Save fib(n-1)
    sw x10, 0(sp)
    # Restore original n
    lw x10, 4(sp)
    # Calculate n-2
    addi x10, x10, -2
    jal x1, fib
    # x10 = fib(n-2)
    # x6 = fib(n-1)
    lw x6, 0(sp)
    add x10, x6, x10     # fib(n-1) + fib(n-2)
    # Restore return address
    lw x1, 8(sp)
    # Remove stack frame
    addi sp, sp, 12
    jalr x0, 0(x1)

base_zero:
    li x10, 0
    lw x1, 8(sp)
    addi sp, sp, 12
    jalr x0, 0(x1)

base_one:
    li x10, 1
    lw x1, 8(sp)
    addi sp, sp, 12
    jalr x0, 0(x1)
end:
    j end