# # LISITING 3.2 (run for n=5... 5!=120)
main:
    li x10, 5             # n = 5
    jal x1, fact          # Call factorial
    addi x11, x10, 0      # Put answer in x11
    li x10, 1             # print integer
    ecall
    j end

fact:
    addi sp, sp, -8
    sw x1 , 4(sp)
    sw x10 , 0(sp) 
    addi x5 , x10 , -1 
    bge x5 , x0 , L1 
    addi x10 , x0 , 1
    addi sp , sp , 8 
    jalr x0 , 0(x1) 
L1:
    addi x10 , x10 , -1
    jal x1 , fact 
    addi x6 , x10 , 0 
    lw x10 , 0(sp) 
    lw x1 , 4(sp) 
    addi sp , sp , 8 
    mul x10 , x10 , x6
    jalr x0 , 0(x1) 
end:
    j end


# --> part (b)  run for n=5 to match answers
main:
    li x10, 5             # n = 5
    jal x1, fact_iter     # Call factorial
    addi x11, x10, 0      # Move result to x11
    li x10, 1             # Print integer
    ecall
    j end

fact_iter:
    li x5, 1              # acc = 1
loop:
    bge x0, x10, done     # if n <= 0, finish
    mul x5, x5, x10       # acc = acc * n
    addi x10, x10, -1     # n = n - 1
    jal x0, loop          # Repeat

done:
    addi x10, x5, 0       # Return acc
    jalr x0, 0(x1)        # Return

end:
    j end