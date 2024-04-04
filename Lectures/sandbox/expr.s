    @ a comment
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    mov r0, #14 //a
    mov r1, #3   //b
    mov r2, #22  //c
    mov r3, #10  // d

    // (a - 2*b) + (c-d)
expr:

    lsl r1, r1, #1 //  b = b * 2
    sub r0, r0, r1  // a = a - b
    sub r2, r2, r3 // c = c-d
    
    add r0, r0, r2


    mov pc, lr
    .size main, .-main
