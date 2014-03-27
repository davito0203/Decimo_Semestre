	.file	"main.c"
	.section	.text
	.align 4
	.global	main
	.type	main, @function
main:
	addi     sp, sp, -72
	sw       (sp+12), r11
	sw       (sp+8), fp
	sw       (sp+4), ra
	addi     fp, r0, 72
	add      fp, fp, sp
	addi     r1, r0, 27
	sw       (fp+-8), r1
	addi     r1, r0, 0
	sw       (fp+-12), r1
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	lw       r1, (r1+0)
	sw       (fp+-8), r1
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	lw       r1, (r1+4)
	sw       (fp+-12), r1
	addi     r1, r0, 0
	sw       (fp+-16), r1
	addi     r1, r0, 0
	sw       (fp+-20), r1
	addi     r1, r0, 0
	sw       (fp+-24), r1
	addi     r1, r0, 0
	sw       (fp+-28), r1
	addi     r1, r0, 0
	sw       (fp+-32), r1
	addi     r1, r0, 0
	sw       (fp+-36), r1
	addi     r1, r0, 0
	sw       (fp+-40), r1
	addi     r1, r0, 0
	sw       (fp+-44), r1
	addi     r1, r0, 0
	sw       (fp+-48), r1
	addi     r1, r0, 0
	sw       (fp+-52), r1
	addi     r1, r0, 1
	sw       (fp+-56), r1
	addi     r1, r0, 27
	sw       (fp+0), r1
	addi     r1, r0, 28
	sw       (fp+-4), r1
.L41:
	lw       r1, (fp+-48)
	addi     r2, r0, 6
	bgu    r1,r2,.L2
	add      r1, r1, r1
	add      r1, r1, r1
	orhi     r2, r0, hi(.L10)
	ori      r2, r2, lo(.L10)
	add      r1, r1, r2
	lw       r1, (r1+0)
	b        r1
	.section	.rodata
	.align 4
	.align 4
.L10:

	.word	.L3

	.word	.L4

	.word	.L5

	.word	.L6

	.word	.L7

	.word	.L8

	.word	.L9
	.section	.text
.L3:
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+12), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+16), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+20), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+24), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 1
	sw       (r1+28), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+32), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+36), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+40), r2
	bi       .L11
.L4:
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 1
	sw       (r1+12), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 1
	sw       (r1+16), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+20), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+24), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 1
	sw       (r1+28), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r11, (r1+0)
	lw       r1, (fp+-8)
	calli    Cancion_Select
	sw       (r11+32), r1
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 1
	sw       (r1+36), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r11, (r1+0)
	lw       r1, (fp+-8)
	calli    Cancion_Select
	sw       (r11+40), r1
	bi       .L11
.L5:
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+12), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+16), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+20), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+24), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 1
	sw       (r1+28), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	lw       r2, (fp+-36)
	sw       (r1+32), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 2
	sw       (r1+36), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r11, (r1+0)
	lw       r1, (fp+-8)
	calli    Nivel_Select
	sw       (r11+40), r1
	lw       r1, (fp+-8)
	calli    Nivel_Select
	sw       (fp+-52), r1
	bi       .L11
.L6:
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+12), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r11, (r1+0)
	lw       r1, (fp+-52)
	calli    Led_Select
	sw       (r11+16), r1
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 1
	sw       (r1+20), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 1
	sw       (r1+24), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+28), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	lw       r2, (fp+-36)
	sw       (r1+32), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 3
	sw       (r1+36), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	lw       r2, (fp+-44)
	sw       (r1+40), r2
	bi       .L11
.L7:
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+12), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+16), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+20), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+24), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 1
	sw       (r1+28), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	lw       r2, (fp+-36)
	sw       (r1+32), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 4
	sw       (r1+36), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	lw       r2, (fp+-44)
	sw       (r1+40), r2
	bi       .L11
.L8:
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 1
	sw       (r1+12), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r11, (r1+0)
	lw       r1, (fp+-52)
	calli    Led_Select
	sw       (r11+16), r1
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+20), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 1
	sw       (r1+24), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+28), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	lw       r2, (fp+-36)
	sw       (r1+32), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 5
	sw       (r1+36), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	lw       r2, (fp+-44)
	sw       (r1+40), r2
	bi       .L11
.L9:
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+12), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+16), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+20), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+24), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 1
	sw       (r1+28), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	lw       r2, (fp+-36)
	sw       (r1+32), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 6
	sw       (r1+36), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r11, (r1+0)
	lw       r1, (fp+-8)
	calli    Select_OV
	sw       (r11+40), r1
	lw       r1, (fp+-8)
	calli    Select_OV
	sw       (fp+-56), r1
	bi       .L11
.L2:
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+12), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+16), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+20), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+24), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 1
	sw       (r1+28), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+32), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+36), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+40), r2
.L11:
	lw       r1, (fp+-48)
	addi     r2, r0, 6
	bgu    r1,r2,.L12
	add      r1, r1, r1
	add      r1, r1, r1
	orhi     r2, r0, hi(.L20)
	ori      r2, r2, lo(.L20)
	add      r1, r1, r2
	lw       r1, (r1+0)
	b        r1
	.section	.rodata
	.align 4
	.align 4
.L20:

	.word	.L13

	.word	.L14

	.word	.L15

	.word	.L16

	.word	.L17

	.word	.L18

	.word	.L19
	.section	.text
.L13:
	lw       r2, (fp+-8)
	lw       r1, (fp+0)
	bne    r2,r1,.L21
	addi     r1, r0, 1
	sw       (fp+-48), r1
	bi       .L22
.L21:
	lw       r1, (fp+-48)
	sw       (fp+-48), r1
.L22:
	bi       .L23
.L14:
	lw       r2, (fp+-8)
	lw       r1, (fp+0)
	bne    r2,r1,.L24
	addi     r1, r0, 2
	sw       (fp+-48), r1
	bi       .L25
.L24:
	lw       r2, (fp+-8)
	lw       r1, (fp+-4)
	bne    r2,r1,.L26
	addi     r1, r0, 0
	sw       (fp+-48), r1
	bi       .L25
.L26:
	lw       r1, (fp+-48)
	sw       (fp+-48), r1
.L25:
	bi       .L23
.L15:
	lw       r2, (fp+-8)
	lw       r1, (fp+0)
	bne    r2,r1,.L27
	addi     r1, r0, 3
	sw       (fp+-48), r1
	bi       .L28
.L27:
	lw       r2, (fp+-8)
	lw       r1, (fp+-4)
	bne    r2,r1,.L29
	addi     r1, r0, 1
	sw       (fp+-48), r1
	bi       .L28
.L29:
	lw       r1, (fp+-48)
	sw       (fp+-48), r1
.L28:
	bi       .L23
.L16:
	lw       r2, (fp+-12)
	addi     r1, r0, 1
	bne    r2,r1,.L30
	addi     r1, r0, 4
	sw       (fp+-48), r1
	bi       .L31
.L30:
	lw       r2, (fp+-8)
	lw       r1, (fp+-4)
	bne    r2,r1,.L32
	addi     r1, r0, 2
	sw       (fp+-48), r1
	bi       .L31
.L32:
	lw       r1, (fp+-48)
	sw       (fp+-48), r1
.L31:
	bi       .L23
.L17:
	lw       r2, (fp+-8)
	lw       r1, (fp+-4)
	bne    r2,r1,.L33
	addi     r1, r0, 2
	sw       (fp+-48), r1
	bi       .L34
.L33:
	addi     r1, r0, 5
	sw       (fp+-48), r1
.L34:
	bi       .L23
.L18:
	lw       r2, (fp+-8)
	lw       r1, (fp+-4)
	bne    r2,r1,.L35
	addi     r1, r0, 2
	sw       (fp+-48), r1
	bi       .L36
.L35:
	lw       r2, (fp+-12)
	addi     r1, r0, 1
	bne    r2,r1,.L37
	addi     r1, r0, 6
	sw       (fp+-48), r1
	bi       .L36
.L37:
	lw       r1, (fp+-48)
	sw       (fp+-48), r1
.L36:
	bi       .L23
.L19:
	lw       r2, (fp+-8)
	lw       r1, (fp+0)
	bne    r2,r1,.L38
	addi     r1, r0, 0
	sw       (fp+-56), r1
.L38:
	lw       r2, (fp+-8)
	lw       r1, (fp+0)
	bne    r2,r1,.L39
	addi     r1, r0, 1
	sw       (fp+-56), r1
	addi     r1, r0, 0
	sw       (fp+-48), r1
	bi       .L40
.L39:
	lw       r1, (fp+-48)
	sw       (fp+-48), r1
.L40:
	bi       .L23
.L12:
	addi     r1, r0, 0
	sw       (fp+-48), r1
	bi       .L41
.L23:
	bi       .L41
	.size	main, .-main
	.ident	"GCC: (GNU) 4.5.2 20101208 (prerelease)"
