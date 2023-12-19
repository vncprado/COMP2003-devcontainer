	.arch armv4
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 1
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"rsum0_n.c"
	.text
	.align	2
	.global	rsum
	.syntax unified
	.arm
	.fpu softvfp
	.type	rsum, %function
rsum:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	subs	r4, r0, #0
	bne	.L4
.L2:
	mov	r0, r4
	pop	{r4, pc}
.L4:
	sub	r0, r4, #1
	bl	rsum
	add	r4, r4, r0
	b	.L2
	.size	rsum, .-rsum
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
