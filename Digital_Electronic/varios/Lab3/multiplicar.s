	.file	"multiplicar.c"
	.section	.text
	.align 4
	.global	main
	.type	main, @function
main:
	addi     sp, sp, -24
	sw       (sp+8), fp
	sw       (sp+4), ra
	addi     fp, r0, 24
	add      fp, fp, sp
	addi     r1, r0, 4
	sw       (fp+-8), r1
	addi     r1, r0, 3
	sw       (fp+-12), r1
	addi     r1, r0, 0
	sw       (fp+0), r1
	addi     r1, r0, 0
	sw       (fp+-4), r1
	addi     r1, r0, 1
	sw       (fp+0), r1
	bi       .L2
.L3:
	lw       r2, (fp+-4)
	lw       r1, (fp+-8)
	add      r1, r2, r1
	sw       (fp+-4), r1
	lw       r1, (fp+0)
	addi     r1, r1, 1
	sw       (fp+0), r1
.L2:
	lw       r1, (fp+0)
	lw       r2, (fp+-12)
	bge    r2,r1,.L3
	lw       fp, (sp+8)
	lw       ra, (sp+4)
	addi     sp, sp, 24
	b        ra
	.size	main, .-main
	.ident	"GCC: (GNU) 4.5.2 20101208 (prerelease)"
