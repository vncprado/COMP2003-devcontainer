    @ gtlt.s
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    mov    r3, #-3
    mov    r2, #-2
    mov    r5, #5
    mov    r8, #8
    cmp    r3, r2 
    cmp    r2, r3 
    cmp    r5, r8 
    cmp    r8, r5 
    cmp    r3, r8
    cmp    r8, r3

