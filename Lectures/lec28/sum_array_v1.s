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
	.file	"sum_array_v1.c"
	.text
	.align	2
	.global	sum_array
	.syntax unified
	.arm
	.fpu softvfp
	.type	sum_array, %function
sum_array:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #0
	mov	r2, r3
.L2:
	cmp	r3, r1
	blt	.L3
	mov	r0, r2
	mov	pc, lr
.L3:
	ldr	ip, [r0, r3, lsl #2]
	add	r3, r3, #1
	add	r2, r2, ip
	b	.L2
	.size	sum_array, .-sum_array
	.ident	"GCC: (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",%progbits
