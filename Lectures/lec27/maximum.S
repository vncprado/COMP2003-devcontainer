         .arch armv4
        .text
        .align 2
        .global maximum
        .arm
maximum:
        // find maximum of r0, r1, r2, r3
        cmp r0, r1
        movlt r0, r1 // if (r0 < r1) r0 = r1
        cmp r0, r2
        movlt r0, r2 // if (r0 < r2) r0 = r2
        cmp r0, r3
        movlt r0, r3 // if (r0 < r3) r0 = r3
        mov pc, lr // return value in r0
        .size maximum, .-maximum
