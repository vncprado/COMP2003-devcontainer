        .arch armv4
        .text
        .align	2
        .global	main
        .arm
main:
        // find maximum of r0, r1, r2, r3
        mov   r0, #13        // a = 13
        mov   r1, #30         // b = 30
        mov   r2, #22        // c = 22
        mov   r3, #10        // d = 10
        cmp   r0, r1
        movlt r0, r1        // if (r0 < r1) r0 = r1 (N=1? N)
        cmp   r0, r2
        movlt r0, r2        // if (r0 < r2) r0 = r2 (N=1? Y)
        cmp   r0, r3
        movlt r0, r3        // if (r0 < r3) r0 = r3 (N=1? N)
        mov  pc, lr         // return value in r0
        .size main, .-main
