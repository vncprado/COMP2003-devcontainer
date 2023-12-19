    @ cmp_add.s
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    MOV r0, #2    
    MOV r1, #4
    CMP R0, R1
    ADDEQ R0, R0, R1

    mov pc, lr
    .size main, .-main

