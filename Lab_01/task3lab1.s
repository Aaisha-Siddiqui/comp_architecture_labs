
main:
    li x1, 5  #a=5
    li x2, 0 #b=0
    li x3, 0 #d=0
    li x22, 5 #const 5 for subtraction
    addi x2, x2, 0 #b=0+0
    addi x1, x2, 32 #a=b+32
    add x3, x1, x2 #d=a+b
    sub x3, x3, x22 #d=d-5

    li x4, 0 #x4 storing(a-d)=0
    sub x4, x1, x3 #x4=a-d
    li x5, 0 #x5 storing(b-a)=0
    sub x5, x2, x1 #x5=b-a
    li x6, 0 #e=0
    add x6, x4, x5 #e=x4+x5 = (a-d)+(b-a)
    add x6, x6, x3 #e=x6+d = ((a-d)+(b-a)) + d

    add x6, x6, x1 #e=e+a
    add x6, x6, x2 #e=e+a+b
    add x6, x6, x3 #e=e+a+b+d


end:
    j end
