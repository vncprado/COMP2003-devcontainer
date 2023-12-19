         .arch armv4
        .text
        .align 2
        .global count_bits
        .arm
count_bits:
        mov r1, r0
        mov r0, #0
top:
        teq r1, #0     // while test
        beq done       // done when r1 == 0
        and r2, r1, #1 // extract bit0
        add r0, r0, r2 // count bit
        lsr r1, r1, #1 // logic shift right
        b   top        // branch to top
done:
        mov pc, lr     // return value in r0
        .size count_bits, .-count_bits
