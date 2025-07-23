//Runnig commands from slides:
// arm-linux-gnueabi-as -al add.s
//
// arm-linux-gnueabi-as add.s -o add.o  # -o specified the output
// arm-linux-gnueabi-nm -g add.o # -g displays only globals
// arm-linux-gnueabi-objdump -S add.o # disassembled
// rm -f add.o   # clean up files


    @ a comment
    .arch armv4
    .text
    .align 2
    .global main
    .arm

main:
    mov r0, #5
    mov r1, #10
    add r0, r0, r1
    mov pc, lr
    .size main, .-main
    
    
