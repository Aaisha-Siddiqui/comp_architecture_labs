main:
    # Create array v
    li x5, 0x200          # x5 = base address of v[]
    li x22, 0             # i = 0
    li x6, 5              # loop limit = 5
Loop1:
    bge x22, x6, code     # if i >= 5, go to code
    slli x7, x22, 2       # x7 = i * 4
    add x7, x5, x7        # x7 = address of v[i]
    sw x22, 0(x7)         # v[i] = i
    addi x22, x22, 1      # i++
    j Loop1
#loop used for testing by making array of 5 integers (0-4)
code:
    li x10, 0x200         # x10 = base address of v[]
    li x11, 1             # x11 = k = 1
    jal x1, swap          # call swap
    lw x11, 4(x10)        # x11 = v[1]
    li x10, 1             # ecall 1 = print integer
    ecall
    j end
# swaps v[k] and v[k+1]
swap:
    slli x11, x11, 2      # x11 = k * 4
    add x13, x10, x11     # x13 = address of v[k]
    lw x12, 0(x13)        # x12 = v[k]
    lw x14, 4(x13)        # x14 = v[k+1]
    sw x14, 0(x13)        # v[k] = v[k+1]
    sw x12, 4(x13)        # v[k+1] = v[k]
    jalr x0, 0(x1)        # return

end:
    j end