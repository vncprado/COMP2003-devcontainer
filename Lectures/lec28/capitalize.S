        .arch armv4
        .text

        .align	2
        .global	capitalize
        .syntax unified
        .arm
        // r0 is dest string
        // r1 is src string
        // Stings in C are byte arrays terminated by NUL
        // assume dest is big enough
capitalize:
        mov  r2, #0 
top:
        ldrb  r3, [r1, r2]     // get char
        teq   r3, #0
        beq   done             // exit if NUL '\0'
        cmp   r3, #'a          // check if a lower case letter
        blt   skip             // below 'a', not lowercase
        cmp   r3, #'z          // check if between 'a' and 'z'
        bgt   skip             // above 'z'
        bic   r3, r3, #0x20    // cover lower to upper
skip:
        strb  r3, [r0, r2]     // copy character
        add   r2, r2, #1
        b     top
done:
        strb  r3, [r0, r2]     // copy NUL character
        mov   pc, lr
