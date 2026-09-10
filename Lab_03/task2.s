main:
    li x10, 1             # g
    li x11, 2             # h
    li x12, 3             # i
    li x13, 4             # j
    li x18,5
    li x19,5
    li x20,5
    li sp, 0x200
    addi sp, sp, -12
    jal x3, calculate
    # Print result from x21
    addi x11, x21, 0
    li x10, 1
    ecall
    j end
calculate:
    # Save values
    sw x18, 0(sp)
    sw x19, 4(sp)
    sw x20, 8(sp)
    # Calculate
    add x18, x10, x11     # g + h
    add x19, x12, x13     # i + j
    sub x20, x18, x19     # result = -4
    addi x21, x20,0    #since we are restoring original value of x20 we will return the result using another register
   #restore values
    lw x18, 0(sp)
    lw x19, 4(sp)
    lw x20, 8(sp)
    addi sp, sp, 12

    jalr x0, 0(x3)
end:
    j end



#what sir made us do for stack application

# main:
#     li x10, 1             # g
#     li x11, 2             # h
#     li x12, 3             # i
#     li x13, 4             # j
#     li sp, 0x200
#     addi sp, sp, -16
#     jal x3, calculate
#     # Print result from x20
#     addi x11, x20, 0
#     li x10, 1
#     ecall
#     j end
# calculate:
#     # Save values
#     sw x10, 0(sp)
#     sw x11, 4(sp)
#     sw x12, 8(sp)
#     sw x13, 12(sp)
#     #restore in other reg
#     lw x21, 0(sp)
#     lw x22, 4(sp)
#     lw x23, 8(sp)
#     lw x24, 12(sp)
#     # Calculate
#     add x18, x21, x22     # g + h
#     add x19, x23, x24     # i + j
#     sub x20, x18, x19     # result = -4

#     addi sp, sp, 16

#     jalr x0, 0(x3)
# end:
#     j end

