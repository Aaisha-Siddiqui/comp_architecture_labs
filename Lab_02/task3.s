main:
    li x5, 0x200          # Base address of array a
    # First loop: a[i] = i
    li x22, 0             # i = 0
    li x6, 10             # loop limit = 10
    Loop1:
        bge x22, x6, SumStart   # if i >= 10, go to second loop
        slli x7, x22, 2         # x7 = i * 4
        add x7, x5, x7          # x7 = address of a[i]
        sw x22, 0(x7)           # a[i] = i
        addi x22, x22, 1        # i++
        j Loop1

    # Second loop: sum = sum + a[i]
    SumStart:
        li x22, 0               # i = 0
        li x23, 0               # sum = 0
    Loop2:
        bge x22, x6, end       # if i >= 10, exit
        slli x7, x22, 2         # x7 = i * 4
        add x7, x5, x7          # address of a[i]
        lw x28, 0(x7)           # load a[i]
        add x23, x23, x28       # sum = sum + a[i]
        addi x22, x22, 1        # i++
        j Loop2

end:
    j end                  