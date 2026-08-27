main:
    li x2, 0x100  #a
    li x3, 0x200  #b
    li x4, 0x300  #c

    # i=0
    lb x7, 0(x2)                         #0x1 byte = 0 offset
    lh x8, 0(x3)                         #0x2 byte
    add x9, x7, x8 # a[0]+b[0]
    sw x9, 0(x4)                         #0x4 byte

    #i=1
    lb x10, 1(x2)                        #1x1 byte
    lh x11, 2(x3)                         #1x2 bytes = 2 offset
    add x12, x10, x11 # a[1]+b[1]
    sw x12, 4(x4)                         #1x4 byte

    #i=2
    lb x13, 2(x2)                        #2x1 byte
    lh x14, 4(x3)                         #2x2 bytes = 4 offset
    add x15, x13, x14 # a[2]+b[2]
    sw x15, 8(x4)                         #2x4 byte

    #i=3
    lb x16, 3(x2)                        #3x1 byte
    lh x17, 6(x3)                         #3x2 bytes = 6 offset
    add x18, x16, x17 # a[3]+b[3]
    sw x18, 12(x4)                         #3x4 byte
 

end:
    j end
