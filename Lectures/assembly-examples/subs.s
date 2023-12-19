    @ subs.s
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    MOV  R0, #0         // R0 = 0
    SUB  R0, R0, #1     // R0 = -1, do not set N
    MOV  R0, #0 
    SUBS R0, R0, #1     // R0 = -1, set N
    mov pc, lr
    .size main, .-main
