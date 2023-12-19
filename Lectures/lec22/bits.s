        .arch armv4
        .text
        .align	2
        .global	main
        .arm
main:
        mov  r0, #0
        mov  r1, #0x3e80
top:
        cmp  r1, #0       // while test
        beq  done         // done when r1 == 0
        and  r2, r1, #1   // extract bit0
        add  r0, r0, r2   // count bit
        lsr  r1, r1, #1   // logic shift right
        b    top          // branch to top
done:
        mov  pc, lr         // return value in r0
        .size main, .-main
