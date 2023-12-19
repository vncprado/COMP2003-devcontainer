	.arch armv5t
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"andbits.c"
	.text
	.align	2
	.global	print_binary
	.syntax unified
	.arm
	.fpu softvfp
	.type	print_binary, %function
print_binary:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	mov	r3, r0
	strb	r3, [fp, #-13]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L2
.L5:
	ldrsb	r3, [fp, #-13]
	cmp	r3, #0
	bge	.L3
	mov	r0, #49
	bl	putchar
	b	.L4
.L3:
	mov	r0, #48
	bl	putchar
.L4:
	ldrb	r3, [fp, #-13]
	lsl	r3, r3, #1
	strb	r3, [fp, #-13]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L2:
	ldr	r3, [fp, #-8]
	cmp	r3, #7
	ble	.L5
	nop
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	print_binary, .-print_binary
	.section	.rodata
	.align	2
.LC0:
	.ascii	"./andbits v1 v2\000"
	.align	2
.LC1:
	.ascii	" & \000"
	.align	2
.LC2:
	.ascii	" = \000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	ldr	r3, [fp, #-16]
	cmp	r3, #3
	beq	.L7
	ldr	r0, .L9
	bl	puts
	mov	r3, #1
	b	.L8
.L7:
	ldr	r3, [fp, #-20]
	add	r3, r3, #4
	ldr	r3, [r3]
	mov	r2, #2
	mov	r1, #0
	mov	r0, r3
	bl	strtol
	mov	r3, r0
	strb	r3, [fp, #-6]
	ldr	r3, [fp, #-20]
	add	r3, r3, #8
	ldr	r3, [r3]
	mov	r2, #2
	mov	r1, #0
	mov	r0, r3
	bl	strtol
	mov	r3, r0
	strb	r3, [fp, #-5]
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	mov	r0, r3
	bl	print_binary
	ldr	r0, .L9+4
	bl	printf
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	mov	r0, r3
	bl	print_binary
	ldr	r0, .L9+8
	bl	printf
	ldrb	r2, [fp, #-6]
	ldrb	r3, [fp, #-5]
	and	r3, r3, r2
	and	r3, r3, #255
	mov	r0, r3
	bl	print_binary
	mov	r0, #10
	bl	putchar
	mov	r3, #0
.L8:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L10:
	.align	2
.L9:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu1) 9.3.0"
	.section	.note.GNU-stack,"",%progbits
