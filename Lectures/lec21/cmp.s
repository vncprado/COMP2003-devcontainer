    @ cmp.s
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    mov R0, #1
    mov R1, #1
    CMP R0, R1 // 
    ADDEQ R0, R0, R1 // only execute if Z is setted
    mov pc, lr
    .size main, .-main

