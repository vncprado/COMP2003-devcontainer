    @ eq.s
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    mov    r5, #47
    mov    r6, #47
    cmp    r5, r6         // r5 - r6, descarding result
    adds   r0, r5, r6     // clear Z flag
    cmp    r5, r6         // r5 - r6
    mov    pc, lr
    .size main, .-main
