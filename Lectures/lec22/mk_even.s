        .arch armv4
        .text
        .align	2
        .global	main
        .arm
main:
        // make even if odd
        mov   r0, #12        // a = 12
        tst   r0, #1         // check bit 0
        beq   skip_if        // skip if result is 0 (Z=1? N)
        add   r0, r0, #1
skip_if:
        mov  pc, lr         // return value in r0
        .size main, .-main
