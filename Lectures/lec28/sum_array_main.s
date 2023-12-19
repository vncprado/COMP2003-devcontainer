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
	.file	"sum_array_main.c"
	.text
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #24
	mov	ip, sp
	ldr	r4, .L4
	ldr	lr, .L4+4
	ldr	r3, [r4]
	str	r3, [sp, #20]
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldr	r3, [lr]
	mov	r1, #5
	mov	r0, sp
	str	r3, [ip]
	bl	sum_array
	ldr	r1, .L4+8
	mov	r2, r0
	mov	r0, #1
	bl	__printf_chk
	mov	r1, #3
	mov	r0, sp
	bl	sum_array
	ldr	r1, .L4+8
	mov	r2, r0
	mov	r0, #1
	bl	__printf_chk
	ldr	r2, [sp, #20]
	ldr	r3, [r4]
	cmp	r2, r3
	blne	__stack_chk_fail
.L2:
	mov	r0, #0
	add	sp, sp, #24
	@ sp needed
	pop	{r4, pc}
.L5:
	.align	2
.L4:
	.word	__stack_chk_guard
	.word	.LANCHOR0
	.word	.LC1
	.size	main, .-main
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
.LC0:
	.word	2
	.word	5
	.word	8
	.word	3
	.word	10
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC1:
	.ascii	"sum is %d\012\000"
	.ident	"GCC: (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",%progbits
