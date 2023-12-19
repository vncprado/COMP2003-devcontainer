        .arch armv4
        .text
        .align	2
        .global	main
        .arm
main:
        mov  r0, #0
        mov  r1, #0x3e80  // test input, random number
top:
        and  r2, r1, #1   // extract bit0
        add  r0, r0, r2   // count bit
        lsr  r1, r1, #1   // logic shift right
        cmp  r1, #0       // while test
        bne  top          // done when r1 == 0
done:
        mov  pc, lr         // return value in r0
        .size main, .-main
