    @ zflag.s
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    mov     r0, #6
    teq    r0, r0         // r0^r0, test and sets zero flag
    adds   r0, r0, #1     // r0 = 1, clears zero flag  
    subs   r0, r0, #1     // r0 = 0, sets zero flag, 1-1 causes a carry
    add    r0, r0, #1     // r0 = 1, flags not affected
    mov pc, lr
    .size main, .-main

