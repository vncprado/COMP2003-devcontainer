         .arch armv4
        .text
        .align 2
        .global ifelse
        .arm
ifelse:
        cmp r0, r1 // if test
        ble skip_if
        mov r1, #5 // if body
        mov r2, #7
        b skip_else
skip_if:
        mov r1, #10 // else body
        mov r2, #14
skip_else:
        add r0, r1, r2
        mov pc, lr // return value in r0
        .size ifelse, .-ifelse
