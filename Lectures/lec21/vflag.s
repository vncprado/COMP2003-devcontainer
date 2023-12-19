    @ zflag.s
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    mov    r0, #-1       
    lsr    r0, r0, #1      // r0 is all 1 except the sign bit
    adds   r1, r0, r0      // cause an overflow
    adds   r0, r0, #0      // reset overflow flag
    mov    r2, #1          // create the most negative value
    ror    r2, r2, #1      // set the sign bit with rotate ror
    adds   r1, r2, r2      // cause an overflow
    mov    pc, lr
    .size main, .-main
