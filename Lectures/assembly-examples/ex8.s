        .arch armv4
        .syntax unified
        .arm
        .text
        .align 2

        .global test
        .type   test, %function
test:
top:
        cmp r0, r1
        beq done
        cmp r0, r1
        blt if_else
        sub r0, r0, r1
if_else:
        sub r1, r1, r0 
        b top
done:
        mov  pc, lr

