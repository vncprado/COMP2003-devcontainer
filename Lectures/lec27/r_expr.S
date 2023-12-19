         .arch armv4
        .text
        .align 2
        .global r_expr
        .arm
r_expr:
        // expression for (a - 2*b) + (c-d)
        // a is r0, b is r1, c is r2, d is r3
        lsl r1, r1, #1 // b = 2 * b
        sub r0, r0, r1 // a = a - b
        sub r2, r2, r3 // c = c - d
        add r0, r0, r2 // a = a + c
        mov pc, lr 
