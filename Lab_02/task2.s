main:
    # x21 = a
    li x20, 2          # x = 2     x20 = x
    li x22, 5          # b = 5     x22 = b
    li x23, 3          # c = 3     x23 = c
    li x6, 1
    li x7, 2
    li x8, 3
    li x9, 4
    beq x20, x6, Case1
    beq x20, x7, Case2
    beq x20, x8, Case3
    beq x20, x9, Case4
    beq x0, x0, Default

Case1:
    add x21, x22, x23       # a = b + c
    beq x0, x0, Exit
Case2:
    sub x21, x22, x23       # a = b - c
    beq x0, x0, Exit
Case3:
    slli x21, x22, 1       # a = b*2
    beq x0, x0, Exit
Case4:
    srai x21, x22, 1        # a = b / 2
    beq x0, x0, Exit

Default:
    li x21, 0               # a = 0
Exit:
end:
    j end 