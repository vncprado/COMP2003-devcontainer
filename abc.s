        @ a comment
        .arch armv4
        .text
        .align	2
        .global	main
        .arm
main:
        mov r0, #5
        mov r1, #7
        add r0, r0, r1
        mov pc, lr
        .size main, .-main
