        .arch armv4
        .text
        .align  2
        .global main
        .arm
main:
        // multiply r0 by 19
        mov  r0, #10             // r0 = 10 
        lsl  r1, r0, #4          // r1 = r0 * 16
        add  r1, r1, r0, lsl #1  // r1 = r1 + r0 * 2
        add  r0, r0, r1          // r0 = r0 + r1
        mov  pc, lr         // return value in r0
        .size main, .-main
