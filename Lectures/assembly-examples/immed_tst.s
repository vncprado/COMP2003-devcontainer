    @ a comment
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    //ldr r0, #0x00000100
    mov r0, #0x00000100
    add r0, #1
    mov pc, lr
    .size main, .-main
//    mov r0, #0x00000100
//  COND OP I COMM S  Rn   Rd     
//1110 00 1 1101 0 0000 0000 1100 00000001

