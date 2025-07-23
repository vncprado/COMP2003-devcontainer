    @ cmp.s
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    //mov R0, #4
    //mov R1, #2 
    mov R0, #2
    mov R1, #2
    
    CMP R0, R1 // R0 - R1 => set the flags
    ADDEQ R0, R0, R1
    mov pc, lr
    .size main, .-main

