	.file	"main.c"
	.global	__mulsi3
	.section	.rodata
	.align 4
.LC0:
	.string	"El resultado es \r\n"
	.section	.text
	.align 4
	.global	main
	.type	main, @function
main:
	addi     sp, sp, -36
	sw       (sp+8), fp
	sw       (sp+4), ra
	addi     fp, r0, 36
	add      fp, fp, sp
	sw       (fp+-20), r1
	sw       (fp+-24), r2
	addi     r1, r0, 48
	sw       (fp+0), r1
	addi     r1, r0, 4
	sw       (fp+-4), r1
	addi     r1, r0, 0
	sw       (fp+-8), r1
	addi     r1, r0, 0
	sw       (fp+-12), r1
	lw       r1, (fp+0)
	lw       r2, (fp+-4)
	calli    __mulsi3
	sw       (fp+-8), r1
	lw       r1, (fp+-8)
	addi     r1, r1, 48
	sw       (fp+-8), r1
	lw       r1, (fp+-8)
	sb       (fp+-13), r1
	orhi     r1, r0, hi(.LC0)
	ori      r1, r1, lo(.LC0)
	calli    uart_putstr
	lbu      r1, (fp+-13)
	calli    uart_putchar
	addi     r1, r0, 0
	lw       fp, (sp+8)
	lw       ra, (sp+4)
	addi     sp, sp, 36
	b        ra
	.size	main, .-main
	.ident	"GCC: (GNU) 4.5.2 20101208 (prerelease)"
