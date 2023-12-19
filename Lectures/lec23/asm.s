        .arch armv4
        .text
        .align	2
        .global	main
        .arm
main:
        add  r2,r7,r11
        eors r9,r3,r5
        addeq r1,r2,r3
        lsr r3, r5, #4
        mov  pc, lr
        .size main, .-main
