    @ cflag.s
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    mov    r0, #-5
    adds   r0, r0, #10    // r0 = -5 + 10, causes a carry
    mov    r0, #-5
    add    r0, r0, #10    // flags not affected
    mov pc, lr
    .size main, .-main
