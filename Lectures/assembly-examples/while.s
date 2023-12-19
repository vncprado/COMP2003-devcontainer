        .arch armv4
        .text
        .align	2
        .global	main
        .arm
main:
        mov  r0, #0
        mov  r1, #1
top:
        cmp  r1, #16      // while test
        bgt  skip_while   // notice the test is opposite python's (N=0?N Z=0?N)
        add  r0, r0, r1   // while body
        add  r1, r1, #1
        b    top          // branch to top
skip_while:
        mov  pc, lr         // return value in r0
        .size main, .-main
