        .arch armv4t
        .text

        .align  2
        .global c
        .syntax unified
        .arm
        .type   c, %function
c:
        push  {lr}
        ldr   r0, =c_msg
        bl    print
        pop   {lr}
        mov   pc, lr
        .size   c, .-c

        .align  2
        .global b
        .syntax unified
        .arm
        .type   b, %function
b:
        push  {lr}
        ldr   r0, =b_start_msg
        bl    print
        bl    c
        ldr   r0, =b_end_msg
        bl    print
        pop   {lr}
        mov   pc, lr
        .size   b, .-b

        .align  2
        .global a
        .syntax unified
        .arm
        .type   a, %function
a:
        push  {lr}
        ldr   r0, =a_start_msg   // set r0 to start message
        bl    print
        bl    b
        ldr   r0, =a_end_msg     // set r0 to end message
        bl    print
        pop   {lr}
        mov   pc, lr
        .size   a, .-a

    @ a comment
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    bl _start
    mov pc, lr
    .size main, .-main

        .align  2
        .global _start
        .syntax unified
        .arm
        .type   start, %function
_start:
        bl  a

        mov r0, #0 // exit sys call
        mov r7, #1 
        swi #0
        .size   _start, .-_start

        .align  2
        .syntax unified
        .arm
        .type   print, %function
print:  // r0 is NUL terminated string
        push  {r7}
        mov   r1, #0
print_cnt:
        ldrb r2,[r0,r1] // count to '\0'
        cmp  r2, #0
        beq  print_pr
        add  r1, r1, #1
        b    print_cnt
print_pr:
        // write syscall
        mov  r2, r1  // byte count
        mov  r1, r0  // bytes to write
        mov  r0, #1  // stdout
        mov  r7, #4  // write syscall
        swi  #0
        pop  {r7}
        mov  pc, lr

        .section .rodata
        .align  2
c_msg:
        .asciz  "start/end\n"
        .align  2
b_start_msg:
        .asciz  "start b\n"
        .align  2
b_end_msg:
        .asciz  "end b\n"
        .align  2
a_start_msg:
        .asciz  "start a\n"
        .align  2
a_end_msg:
        .asciz  "end a\n"
