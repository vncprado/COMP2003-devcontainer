    @ cmp.s
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    //mov R0, #4
    //mov R1, #2 //
    mov R0, #2
    mov R1, #4
    
    CMP R0, R1 // R0 - R1 => set the flags
    mov pc, lr
    .size main, .-main

