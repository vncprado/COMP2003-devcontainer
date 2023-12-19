        .arch armv4
        .text

        .align	2
        .global	sum_array
        .syntax unified
        .arm
        // r0 contains start of array
        // r1 number of entries to sum
sum_array:
        mov  r2, r0       // r2 is now the start of the array
        eor  r0, r0, r0   // r0 = 0

top:
        subs  r1, r1, #1  // sum from the end 
        blt   done
        ldr   r3, [r2, r1, lsl #2]  // r3 = r2[ r1*4 ]
        add   r0, r0, r3
        b     top
done:
        mov   pc, lr
