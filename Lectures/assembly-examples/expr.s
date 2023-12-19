        .arch armv4
        .text
        .align	2
        .global	main
        .arm
main:
        // expression for (a - 2*b) + (c-d)
        // r0 is a, r1 is b, r2 is c, r3 is d
        mov  r0, #14        // a = 14
        mov  r1, #3         // b = 3
        mov  r2, #22        // c = 22
        mov  r3, #10        // d = 10
        lsl  r1, r1, #1     // b = 2 * b
        sub  r0, r0, r1     // a = a - b
        sub  r2, r2, r3     // c = c - d
        add  r0, r0, r2     // a = a + c
        mov  pc, lr         // return value in r0
        .size main, .-main
