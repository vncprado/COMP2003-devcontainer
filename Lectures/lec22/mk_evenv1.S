        .arch armv4
        .text
        .align	2
        .global	main
        .arm
main:
        // make even if odd
        mov   r0, #13        // a = 13
        tst   r0, #1         // check bit 0
        beq   skip_if        // skip if result is 0 (Z=1? N)
        add   r0, r0, #1     // make even
        mov   r1, #8         // r1 = 8
        mov   r2, #400       // r2 = 400
skip_if:
        mov  pc, lr         // return value in r0
        .size main, .-main
