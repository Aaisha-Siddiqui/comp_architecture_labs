main:
    li x10, 0x200      # base address of D
    li x5, 3           # a = 3
    li x6, 4           # b = 4
    li x7, 0              # i = 0
    OUTER:
            beq  x7, x5, end      # if i == a, exit outer loop
            li   x29, 0             # j = 0
    INNER:
            beq  x29, x6, NEXT_I    # if j == b, go to next i
            add  x11, x7, x29       # x11 = i + j
            slli x12, x29, 4        # x12 = j * 16
            add  x12, x10, x12      # x12 = address of D[4*j]
            sw   x11, 0(x12)        # D[4*j] = i + j
            addi x29, x29, 1        # j++
            bne  x29, x6, INNER     # if j != b, repeat inner loop
    NEXT_I:
            addi x7, x7, 1          # i++
            bne  x7, x5, OUTER      # if i != a, repeat outer loop

end:
    j end