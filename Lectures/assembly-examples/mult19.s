        .arch armv4
        .text
        .align	2
        .global	main
        .arm
main:
        // multiply r0 by 19
        // a << 4 + a + a + a = 16*a + 3*a = 19*a
        mov  r0, #10        // r0 = 10, will be passade as parameter
        mov  r1, r0         // save orginal value of r0
        lsl  r0, r0, #4     // r0 = r0 * 16
        add  r0, r0, r1     // r0 = r0 + r1
        add  r0, r0, r1     // r0 = r0 + r1
        add  r0, r0, r1     // r0 = r0 + r1
        mov  pc, lr         // return value in r0
        .size main, .-main
