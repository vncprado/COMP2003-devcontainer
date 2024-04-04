	.arch armv4
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 4
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"expr_main.c"
	.text
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC0:
	.ascii	"r_expr(2, 1, 4, 1) = %d\012\000"
.LC1:
	.ascii	"r_expr(14, 3, 22, 10) = %d\012\000"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r3, #1
	push	{r4, lr}
	mov	r1, r3
	mov	r2, #4
	mov	r0, #2
	bl	r_expr
	ldr	r1, .L3
	mov	r2, r0
	mov	r0, #1
	bl	__printf_chk
	mov	r3, #10
	mov	r2, #22
	mov	r1, #3
	mov	r0, #14
	bl	r_expr
	ldr	r1, .L3+4
	mov	r2, r0
	mov	r0, #1
	bl	__printf_chk
	mov	r0, #0
	pop	{r4, pc}
.L4:
	.align	2
.L3:
	.word	.LC0
	.word	.LC1
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
