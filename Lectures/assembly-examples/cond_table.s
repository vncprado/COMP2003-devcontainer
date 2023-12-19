    @ a comment
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    mov r0, #0
    mov r1, #0
    cmp r0, r1 // EQ=Z
    mov r0, #0
    mov r1, #1
    cmp r0, r1 // LO=~C
    mov r0, #0
    mov r1, #1
    cmp r0, r1 // LS=~Z&C
    mov pc, lr
