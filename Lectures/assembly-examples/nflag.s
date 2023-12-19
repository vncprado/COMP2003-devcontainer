    @ nflag.s
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    mov    r0, #0         // r0 = 0,
    subs   r0, r0, #1     // r0 = -1, sets N flag
    adds   r0, r0, #1     // r0 = 0, clears N flag, causes a carry
    sub    r0, r0, #1     // r0 = -1, flags not affected
    mov pc, lr
    .size main, .-main
