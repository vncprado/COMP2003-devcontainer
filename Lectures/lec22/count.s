        .arch armv4
        .text
        .align	2
        .global	main
        .arm
main:
        // count zeros
        mov   r0, #6        // r0 = 6 (0110)
        mov   r1, r0
        mov   r0, #0        // r0 = 0
        tst   r1, #1        // check bit0
        addne r0, r0, #1        // if ( r1 & 1 ) r0 += 1 (Z=0, N)
        tst   r1, #2        // check bit1
        addne r0, r0, #1        // if ( r1 & 2 ) r0 += 1 (Z=0, Y)
        tst   r1, #4        // check bit2
        addne r0, r0, #1        // if ( r1 & 4 ) r0 += 1 (Z=0, Y)
        tst   r1, #8        // check bit3
        addne r0, r0, #1        // if ( r1 & 8 ) r0 += 1 (Z=0, N)
        mov  pc, lr         // return value in r0
        .size main, .-main
