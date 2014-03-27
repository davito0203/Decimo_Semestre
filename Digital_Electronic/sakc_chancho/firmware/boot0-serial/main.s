	.file	"main.c"
	.global	ADC0
	.section	.data
	.align 4
	.type	ADC0, @object
	.size	ADC0, 4
ADC0:
	.long	-268173312
	.global	display0
	.align 4
	.type	display0, @object
	.size	display0, 4
display0:
	.long	-268238848
	.section	.text
	.align 4
	.global	uart_get_putint
	.type	uart_get_putint, @function
uart_get_putint:
	addi     sp, sp, -16
	sw       (sp+4), ra
	addi     r1, r0, 0
	sw       (sp+12), r1
	addi     r1, r0, 0
	sw       (sp+16), r1
	bi       .L2
.L3:
	lw       r1, (sp+12)
	sli      r1, r1, 1
	sli      r2, r1, 2
	add      r1, r1, r2
	sw       (sp+12), r1
	calli    uart_getchar
	sw       (sp+8), r1
	lw       r1, (sp+8)
	andi     r1, r1, 0xff
	calli    uart_putchar
	lw       r2, (sp+12)
	lw       r1, (sp+8)
	add      r1, r2, r1
	addi     r1, r1, -48
	sw       (sp+12), r1
	lw       r1, (sp+16)
	addi     r1, r1, 1
	sw       (sp+16), r1
.L2:
	lw       r1, (sp+16)
	addi     r2, r0, 2
	bge    r2,r1,.L3
	lw       r1, (sp+12)
	lw       ra, (sp+4)
	addi     sp, sp, 16
	b        ra
	.size	uart_get_putint, .-uart_get_putint
	.align 4
	.global	update_display_state
	.type	update_display_state, @function
update_display_state:
	addi     sp, sp, -12
	sw       (sp+4), ra
	sw       (sp+12), r1
	sw       (sp+8), r2
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r2, (r1+0)
	addi     r1, r0, 3
	bg     r2,r1,.L5
	lw       r2, (sp+12)
	addi     r1, r0, 1
	bne    r2,r1,.L4
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r3, (r1+0)
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r1, (r1+0)
	addi     r2, r1, 4
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r3, r1
	addi     r1, r1, 4
	sw       (r1+0), r2
	bi       .L4
.L5:
	lw       r2, (sp+12)
	addi     r1, r0, 0
	bne    r2,r1,.L4
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r3, (r1+0)
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r1, (r1+0)
	addi     r2, r1, -4
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r3, r1
	addi     r1, r1, 4
	sw       (r1+0), r2
.L4:
	lw       ra, (sp+4)
	addi     sp, sp, 12
	b        ra
	.size	update_display_state, .-update_display_state
	.align 4
	.global	update_display_criticall
	.type	update_display_criticall, @function
update_display_criticall:
	addi     sp, sp, -12
	sw       (sp+4), ra
	sw       (sp+12), r1
	sw       (sp+8), r2
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r2, (r1+0)
	addi     r1, r0, 0
	be     r2,r1,.L8
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r2, (r1+0)
	addi     r1, r0, 1
	be     r2,r1,.L8
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r2, (r1+0)
	addi     r1, r0, 4
	be     r2,r1,.L8
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r2, (r1+0)
	addi     r1, r0, 5
	bne    r2,r1,.L9
.L8:
	lw       r2, (sp+12)
	addi     r1, r0, 1
	bne    r2,r1,.L7
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r3, (r1+0)
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r1, (r1+0)
	addi     r2, r1, 2
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r3, r1
	addi     r1, r1, 4
	sw       (r1+0), r2
	bi       .L7
.L9:
	lw       r2, (sp+12)
	addi     r1, r0, 0
	bne    r2,r1,.L7
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r3, (r1+0)
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r1, (r1+0)
	addi     r2, r1, -2
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r3, r1
	addi     r1, r1, 4
	sw       (r1+0), r2
.L7:
	lw       ra, (sp+4)
	addi     sp, sp, 12
	b        ra
	.size	update_display_criticall, .-update_display_criticall
	.align 4
	.global	update_display_criticalh
	.type	update_display_criticalh, @function
update_display_criticalh:
	addi     sp, sp, -12
	sw       (sp+4), ra
	sw       (sp+12), r1
	sw       (sp+8), r2
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r2, (r1+0)
	addi     r1, r0, 0
	be     r2,r1,.L13
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r2, (r1+0)
	addi     r1, r0, 2
	be     r2,r1,.L13
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r2, (r1+0)
	addi     r1, r0, 4
	be     r2,r1,.L13
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r2, (r1+0)
	addi     r1, r0, 6
	bne    r2,r1,.L14
.L13:
	lw       r2, (sp+12)
	addi     r1, r0, 1
	bne    r2,r1,.L12
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r3, (r1+0)
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r1, (r1+0)
	addi     r2, r1, 1
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r3, r1
	addi     r1, r1, 4
	sw       (r1+0), r2
	bi       .L12
.L14:
	lw       r2, (sp+12)
	addi     r1, r0, 0
	bne    r2,r1,.L12
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r3, (r1+0)
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r1, (r1+0)
	addi     r2, r1, -1
	lw       r1, (sp+8)
	sli      r1, r1, 2
	add      r1, r3, r1
	addi     r1, r1, 4
	sw       (r1+0), r2
.L12:
	lw       ra, (sp+4)
	addi     sp, sp, 12
	b        ra
	.size	update_display_criticalh, .-update_display_criticalh
	.section	.rodata
	.align 4
.LC0:
	.string	"# \r\n"
	.align 4
.LC1:
	.string	"            |  Maximo   |  Minimo   |  Normal   \r\n"
	.align 4
.LC2:
	.string	"-------------------------------------------------\r\n"
	.align 4
.LC3:
	.string	"  Sensor "
	.align 4
.LC4:
	.string	"  |    "
	.align 4
.LC5:
	.string	"    |    "
	.align 4
.LC6:
	.string	"    "
	.align 4
.LC7:
	.string	"\r\n"
	.align 4
.LC8:
	.string	" \r\n"
	.align 4
.LC9:
	.string	"    Hora   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 \r\n"
	.align 4
.LC10:
	.string	"-------------------------------------------\r\n"
	.align 4
.LC11:
	.string	"   "
	.align 4
.LC12:
	.string	"     "
	.align 4
.LC13:
	.string	"| "
	.align 4
.LC14:
	.string	" "
	.section	.text
	.align 4
	.global	main
	.type	main, @function
main:
	addi     sp, sp, -340
	sw       (sp+4), ra
	sw       (sp+12), r1
	sw       (sp+8), r2
	orhi     r1, r0, hi(ADC0)
	ori      r1, r1, lo(ADC0)
	lw       r1, (r1+0)
	addi     r2, r0, 1
	sw       (r1+0), r2
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r1, (r1+0)
	addi     r2, r0, 1
	sw       (r1+0), r2
	orhi     r1, r0, hi(gpio0)
	ori      r1, r1, lo(gpio0)
	lw       r1, (r1+0)
	addi     r2, r0, 1
	sw       (r1+4), r2
	addi     r1, r0, 0
	sw       (sp+336), r1
	addi     r1, r0, 0
	sw       (sp+336), r1
	bi       .L18
.L19:
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+336)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	addi     r2, r0, 0
	sw       (r1+0), r2
	lw       r1, (sp+336)
	addi     r1, r1, 1
	sw       (sp+336), r1
.L18:
	lw       r1, (sp+336)
	addi     r2, r0, 7
	bge    r2,r1,.L19
	orhi     r1, r0, hi(.LC0)
	ori      r1, r1, lo(.LC0)
	calli    uart_putstr
	orhi     r1, r0, hi(.LC0)
	ori      r1, r1, lo(.LC0)
	calli    uart_putstr
	orhi     r1, r0, hi(.LC1)
	ori      r1, r1, lo(.LC1)
	calli    uart_putstr
	orhi     r1, r0, hi(.LC2)
	ori      r1, r1, lo(.LC2)
	calli    uart_putstr
	addi     r1, r0, 0
	sw       (sp+340), r1
	bi       .L20
.L21:
	orhi     r1, r0, hi(.LC3)
	ori      r1, r1, lo(.LC3)
	calli    uart_putstr
	lw       r1, (sp+340)
	andi     r1, r1, 0xff
	addi     r1, r1, 48
	andi     r1, r1, 0xff
	calli    uart_putchar
	orhi     r1, r0, hi(.LC4)
	ori      r1, r1, lo(.LC4)
	calli    uart_putstr
	calli    uart_get_putint
	or       r3, r1, r0
	lw       r1, (sp+340)
	sli      r1, r1, 2
	sli      r2, r1, 2
	sub      r2, r2, r1
	addi     r1, sp, 344
	add      r1, r1, r2
	addi     r1, r1, -112
	sw       (r1+0), r3
	orhi     r1, r0, hi(.LC5)
	ori      r1, r1, lo(.LC5)
	calli    uart_putstr
	calli    uart_get_putint
	or       r3, r1, r0
	lw       r1, (sp+340)
	sli      r1, r1, 2
	sli      r2, r1, 2
	sub      r2, r2, r1
	addi     r1, sp, 344
	add      r1, r1, r2
	addi     r1, r1, -108
	sw       (r1+0), r3
	orhi     r1, r0, hi(.LC5)
	ori      r1, r1, lo(.LC5)
	calli    uart_putstr
	calli    uart_get_putint
	or       r3, r1, r0
	lw       r1, (sp+340)
	sli      r1, r1, 2
	sli      r2, r1, 2
	sub      r2, r2, r1
	addi     r1, sp, 344
	add      r1, r1, r2
	addi     r1, r1, -104
	sw       (r1+0), r3
	orhi     r1, r0, hi(.LC6)
	ori      r1, r1, lo(.LC6)
	calli    uart_putstr
	orhi     r1, r0, hi(.LC7)
	ori      r1, r1, lo(.LC7)
	calli    uart_putstr
	lw       r1, (sp+340)
	addi     r1, r1, 1
	sw       (sp+340), r1
.L20:
	lw       r1, (sp+340)
	addi     r2, r0, 7
	bge    r2,r1,.L21
	orhi     r1, r0, hi(.LC8)
	ori      r1, r1, lo(.LC8)
	calli    uart_putstr
	orhi     r1, r0, hi(.LC8)
	ori      r1, r1, lo(.LC8)
	calli    uart_putstr
	orhi     r1, r0, hi(.LC9)
	ori      r1, r1, lo(.LC9)
	calli    uart_putstr
	orhi     r1, r0, hi(.LC10)
	ori      r1, r1, lo(.LC10)
	calli    uart_putstr
	addi     r1, r0, 0
	sw       (sp+336), r1
	bi       .L22
.L25:
	orhi     r1, r0, hi(.LC11)
	ori      r1, r1, lo(.LC11)
	calli    uart_putstr
	calli    uart_get_putint
	sw       (sp+328), r1
	lw       r1, (sp+328)
	addi     r2, r1, -48
	lw       r1, (sp+340)
	sli      r1, r1, 2
	sli      r3, r1, 3
	add      r1, r1, r3
	addi     r3, sp, 344
	add      r1, r3, r1
	addi     r1, r1, -328
	sw       (r1+0), r2
	orhi     r1, r0, hi(.LC12)
	ori      r1, r1, lo(.LC12)
	calli    uart_putstr
	addi     r1, r0, 1
	sw       (sp+332), r1
	bi       .L23
.L24:
	orhi     r1, r0, hi(.LC13)
	ori      r1, r1, lo(.LC13)
	calli    uart_putstr
	calli    uart_getchar
	sw       (sp+328), r1
	lw       r1, (sp+328)
	andi     r1, r1, 0xff
	calli    uart_putchar
	lw       r1, (sp+328)
	addi     r3, r1, -48
	lw       r2, (sp+340)
	or       r1, r2, r0
	sli      r1, r1, 3
	add      r1, r1, r2
	lw       r2, (sp+336)
	add      r1, r1, r2
	sli      r1, r1, 2
	addi     r2, sp, 344
	add      r1, r2, r1
	addi     r1, r1, -328
	sw       (r1+0), r3
	orhi     r1, r0, hi(.LC14)
	ori      r1, r1, lo(.LC14)
	calli    uart_putstr
	lw       r1, (sp+332)
	addi     r1, r1, 1
	sw       (sp+332), r1
.L23:
	lw       r1, (sp+332)
	addi     r2, r0, 8
	bge    r2,r1,.L24
	orhi     r1, r0, hi(.LC8)
	ori      r1, r1, lo(.LC8)
	calli    uart_putstr
	lw       r1, (sp+336)
	addi     r1, r1, 1
	sw       (sp+336), r1
.L22:
	lw       r1, (sp+336)
	addi     r2, r0, 5
	bge    r2,r1,.L25
.L41:
	addi     r1, r0, 0
	sw       (sp+340), r1
	bi       .L26
.L40:
	orhi     r1, r0, hi(ADC0)
	ori      r1, r1, lo(ADC0)
	lw       r2, (r1+0)
	lw       r1, (sp+340)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r3, (r1+0)
	lw       r1, (sp+340)
	sli      r1, r1, 2
	sli      r2, r1, 2
	sub      r2, r2, r1
	addi     r1, sp, 344
	add      r1, r1, r2
	addi     r1, r1, -112
	lw       r1, (r1+0)
	bg     r1,r3,.L27
	addi     r1, r0, 1
	lw       r2, (sp+340)
	calli    update_display_criticalh
	addi     r1, r0, 0
	lw       r2, (sp+340)
	calli    update_display_criticall
	bi       .L28
.L27:
	orhi     r1, r0, hi(ADC0)
	ori      r1, r1, lo(ADC0)
	lw       r2, (r1+0)
	lw       r1, (sp+340)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r3, (r1+0)
	lw       r1, (sp+340)
	sli      r1, r1, 2
	sli      r2, r1, 2
	sub      r2, r2, r1
	addi     r1, sp, 344
	add      r1, r1, r2
	addi     r1, r1, -108
	lw       r1, (r1+0)
	bg     r3,r1,.L29
	addi     r1, r0, 1
	lw       r2, (sp+340)
	calli    update_display_criticall
	addi     r1, r0, 0
	lw       r2, (sp+340)
	calli    update_display_criticalh
	bi       .L28
.L29:
	addi     r1, r0, 0
	lw       r2, (sp+340)
	calli    update_display_criticall
	addi     r1, r0, 0
	lw       r2, (sp+340)
	calli    update_display_criticalh
.L28:
	orhi     r1, r0, hi(display0)
	ori      r1, r1, lo(display0)
	lw       r2, (r1+0)
	lw       r1, (sp+340)
	addi     r1, r1, 8
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r2, (r1+0)
	addi     r1, r0, 0
	bne    r2,r1,.L30
	orhi     r1, r0, hi(ADC0)
	ori      r1, r1, lo(ADC0)
	lw       r2, (r1+0)
	lw       r1, (sp+340)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r3, (r1+0)
	lw       r1, (sp+340)
	sli      r1, r1, 2
	sli      r2, r1, 2
	sub      r2, r2, r1
	addi     r1, sp, 344
	add      r1, r1, r2
	addi     r1, r1, -112
	lw       r1, (r1+0)
	bg     r1,r3,.L31
	addi     r1, r0, 0
	lw       r2, (sp+340)
	calli    update_display_state
	bi       .L32
.L31:
	addi     r1, r0, 1
	lw       r2, (sp+340)
	calli    update_display_state
	bi       .L32
.L30:
	addi     r1, r0, 0
	sw       (sp+336), r1
	bi       .L33
.L39:
	orhi     r1, r0, hi(gpio0)
	ori      r1, r1, lo(gpio0)
	lw       r1, (r1+0)
	lw       r2, (r1+8)
	lw       r1, (sp+336)
	sli      r1, r1, 2
	sli      r3, r1, 3
	add      r1, r1, r3
	addi     r3, sp, 344
	add      r1, r3, r1
	addi     r1, r1, -328
	lw       r1, (r1+0)
	bne    r2,r1,.L34
	lw       r1, (sp+340)
	addi     r3, r1, 1
	lw       r2, (sp+336)
	or       r1, r2, r0
	sli      r1, r1, 3
	add      r1, r1, r2
	add      r1, r1, r3
	sli      r1, r1, 2
	addi     r2, sp, 344
	add      r1, r2, r1
	addi     r1, r1, -328
	lw       r2, (r1+0)
	addi     r1, r0, 1
	bne    r2,r1,.L35
	orhi     r1, r0, hi(ADC0)
	ori      r1, r1, lo(ADC0)
	lw       r2, (r1+0)
	lw       r1, (sp+340)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r3, (r1+0)
	lw       r1, (sp+340)
	sli      r1, r1, 2
	sli      r2, r1, 2
	sub      r2, r2, r1
	addi     r1, sp, 344
	add      r1, r1, r2
	addi     r1, r1, -104
	lw       r1, (r1+0)
	bg     r3,r1,.L36
	addi     r1, r0, 1
	lw       r2, (sp+340)
	calli    update_display_state
	bi       .L37
.L36:
	addi     r1, r0, 0
	lw       r2, (sp+340)
	calli    update_display_state
	bi       .L37
.L35:
	addi     r1, r0, 0
	lw       r2, (sp+340)
	calli    update_display_state
	bi       .L37
.L34:
	orhi     r1, r0, hi(ADC0)
	ori      r1, r1, lo(ADC0)
	lw       r2, (r1+0)
	lw       r1, (sp+340)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r3, (r1+0)
	lw       r1, (sp+340)
	sli      r1, r1, 2
	sli      r2, r1, 2
	sub      r2, r2, r1
	addi     r1, sp, 344
	add      r1, r1, r2
	addi     r1, r1, -108
	lw       r1, (r1+0)
	bg     r3,r1,.L38
	addi     r1, r0, 1
	lw       r2, (sp+340)
	calli    update_display_state
	bi       .L37
.L38:
	orhi     r1, r0, hi(ADC0)
	ori      r1, r1, lo(ADC0)
	lw       r2, (r1+0)
	lw       r1, (sp+340)
	sli      r1, r1, 2
	add      r1, r2, r1
	addi     r1, r1, 4
	lw       r3, (r1+0)
	lw       r1, (sp+340)
	sli      r1, r1, 2
	sli      r2, r1, 2
	sub      r2, r2, r1
	addi     r1, sp, 344
	add      r1, r1, r2
	addi     r1, r1, -104
	lw       r1, (r1+0)
	bge    r1,r3,.L37
	addi     r1, r0, 0
	lw       r2, (sp+340)
	calli    update_display_state
.L37:
	lw       r1, (sp+336)
	addi     r1, r1, 1
	sw       (sp+336), r1
.L33:
	lw       r1, (sp+336)
	addi     r2, r0, 5
	bge    r2,r1,.L39
.L32:
	lw       r1, (sp+340)
	addi     r1, r1, 1
	sw       (sp+340), r1
.L26:
	lw       r1, (sp+340)
	addi     r2, r0, 7
	bge    r2,r1,.L40
	bi       .L41
	.size	main, .-main
	.ident	"GCC: (GNU) 4.5.2 20101208 (prerelease)"
