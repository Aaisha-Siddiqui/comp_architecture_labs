main:
    li x10, 5             # n = 5
    jal x1, ntri          # Call ntri
    addi x11, x10, 0      # Put answer in x11
    li x10, 1             # print integer
    ecall
    j end

ntri:
    addi sp, sp, -8
    sw x1 , 4(sp)
    sw x10 , 0(sp) 
    addi x5 , x10 , -1 
    blt x0 , x5 , L1    # if n > 1 or n-1 > 0
    addi x10 , x0 , 1
    addi sp , sp , 8 
    jalr x0 , 0(x1) 
L1:
    addi x10 , x10 , -1      # n = n-1
    jal x1 , ntri 
    addi x6 , x10 , 0 
    lw x10 , 0(sp) 
    lw x1 , 4(sp) 
    addi sp , sp , 8 
    add x10 , x10 , x6
    jalr x0 , 0(x1) 
end:
    j end
