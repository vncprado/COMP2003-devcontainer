        .arch armv4
        .text

        .align	2
        .global	init_seq
        .syntax unified
        .arm
        // r0 contains start of the array
        // r1 number of entries
init_seq:
        mov  r2, #0    // r2 contains sequence count
top:
        cmp   r2, r1   // check for end
        movhs pc, lr   // return if higher or same
        str   r2, [r0, r2, lsl #2]  // r0[ r2*4 ] = r2
        add   r2, r2, #1
        b     top
