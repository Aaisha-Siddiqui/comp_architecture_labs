main:
    li x10, 0x78786464
    li x11, 0xA8A81919
    addi x1, x0, 0x100
    sw x10, 0(x1)

    addi x2, x0, 0x1F0
    sw x11, 0(x2) 

    lhu x12, 0(x1)
    lh x13, 0(x2)
    lw x14, 0(x2)

end:
    j end
