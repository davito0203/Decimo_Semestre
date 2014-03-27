	.file	"main.c"
	.section	.text
	.align 4
	.global	read_uint32
	.type	read_uint32, @function
read_uint32:
	addi     sp, sp, -16
	sw       (sp+8), fp
	sw       (sp+4), ra
	addi     fp, r0, 16
	add      fp, fp, sp
	addi     r1, r0, 0
	sw       (fp+0), r1
	addi     r1, r0, 0
	sw       (fp+-4), r1
	bi       .L2
.L3:
	lw       r1, (fp+0)
	sli      r1, r1, 8
	sw       (fp+0), r1
	calli    uart_getchar
	lw       r2, (fp+0)
	add      r1, r2, r1
	sw       (fp+0), r1
	lw       r1, (fp+-4)
	addi     r1, r1, 1
	sw       (fp+-4), r1
.L2:
	lw       r1, (fp+-4)
	addi     r2, r0, 3
	bgeu   r2,r1,.L3
	lw       r1, (fp+0)
	lw       fp, (sp+8)
	lw       ra, (sp+4)
	addi     sp, sp, 16
	b        ra
	.size	read_uint32, .-read_uint32
	.align 4
	.global	main
	.type	main, @function
main:
	addi     sp, sp, -28
	sw       (sp+8), fp
	sw       (sp+4), ra
	addi     fp, r0, 28
	add      fp, fp, sp
	sw       (fp+-12), r1
	sw       (fp+-16), r2
	calli    uart_init
	addi     r1, r0, 125
	sw       (fp+0), r1
	addi     r1, r0, 1000
	sw       (fp+-4), r1
.L5:
	lw       r2, (fp+0)
	lw       r1, (fp+-4)
	mul      r1, r2, r1
	sw       (fp+-8), r1
	lw       r1, (fp+-8)
	andi     r1, r1, 0xff
	calli    uart_putchar
	bi       .L5
	.size	main, .-main
	.ident	"GCC: (GNU) 4.5.2 20101208 (prerelease)"
