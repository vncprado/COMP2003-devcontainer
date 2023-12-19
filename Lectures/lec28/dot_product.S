        .arch armv4
        .text

        .align	2
        .global	dot_product
        .syntax unified
        .arm
        // r0 contains start of array a
        // r1 contains start of array b
        // r2 entries count
        // r3 is the index into the arrays
dot_product:
        push  {r4,r5,r6}
        mov   r4, r0        // r4 now refers to array a
        eor   r0, r0, r0    // r0 = 0 = result
        mov   r3, r0        // r3 = 0
top:
        cmp   r3, r2
        bhs   done
        ldr   r5, [r4, r3, lsl #2]  // r5 = a[i]
        ldr   r6, [r1, r3, lsl #2]  // r6 = b[i]
        mla   r0, r5, r6, r0        // r0 = (r5*r6) + r0
        add   r3, r3, #1            // i++
        b     top
done:
        pop  {r4,r5,r6}
        mov   pc, lr
