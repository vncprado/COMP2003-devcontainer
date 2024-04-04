    @ a comment
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    mov r0, #1
    lsl r1, r0, #4          // r1 = r0*16
    add r1, r1, r0, lsl #1 // r1 = r1 + (r0 <<1)
    add r0, r0, r1          // r0 = r1 + r0
    mov pc, lr
    .size main, .-main
