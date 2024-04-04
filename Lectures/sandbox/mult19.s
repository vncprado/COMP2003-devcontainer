    @ a comment
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    mov r0, #2
    mov r1, r0
    lsl r0, r0, #4  // r0*16
    add r0, r0, r1 // r0+r1
    add r0, r0, r1 // r0+r1
    add r0, r0, r1 // r0+r1

    mov pc, lr
    .size main, .-main
