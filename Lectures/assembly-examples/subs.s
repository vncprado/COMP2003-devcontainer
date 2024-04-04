    @ subs.s
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    MOV  R0, #9         // R0 = 9
    SUB  R0, R0, #1     // R0 = 8, do not set N
    MOV  R0, #9 
    SUBS R0, R0, #1     // R0 = 8, set N
    mov pc, lr
    .size main, .-main
