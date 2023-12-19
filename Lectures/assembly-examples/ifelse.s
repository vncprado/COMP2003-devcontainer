        .arch armv4
        .text
        .align	2
        .global	main
        .arm
main:
        mov  r0, #6
        mov  r1, #10
        cmp  r0, r1    // if test
        ble  skip_if   // (N=1? Y or Z=1? N)
        mov  r1, #5    // if body
        mov  r2, #7
        b    skip_else
skip_if:
        mov  r1, #10   // else body
        mov  r2, #14
skip_else:
        add r0, r1, r2
        mov  pc, lr         // return value in r0
        .size main, .-main
