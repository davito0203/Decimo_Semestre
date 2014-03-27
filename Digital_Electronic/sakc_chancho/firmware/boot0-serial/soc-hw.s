	.file	"soc-hw.c"
	.global	uart0
	.section	.data
	.align 4
	.type	uart0, @object
	.size	uart0, 4
uart0:
	.long	-268435456
	.global	timer0
	.align 4
	.type	timer0, @object
	.size	timer0, 4
timer0:
	.long	-268369920
	.global	gpio0
	.align 4
	.type	gpio0, @object
	.size	gpio0, 4
gpio0:
	.long	-268304384
	.global	msec
	.section	.bss
	.align 4
	.type	msec, @object
	.size	msec, 4
msec:
	.zero	4
	.section	.text
	.align 4
	.global	sleep
	.type	sleep, @function
sleep:
	addi     sp, sp, -12
	sw       (sp+4), ra
	sw       (sp+8), r1
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	lw       r3, (sp+8)
	ori      r2, r0, 50000
	mul      r2, r3, r2
	sw       (r1+16), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+20), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 10
	sw       (r1+12), r2
.L2:
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	lw       r1, (r1+12)
	sw       (sp+12), r1
	lw       r1, (sp+12)
	andi     r2, r1, 1
	addi     r1, r0, 0
	be     r2,r1,.L2
	lw       ra, (sp+4)
	addi     sp, sp, 12
	b        ra
	.size	sleep, .-sleep
	.align 4
	.global	tic_init
	.type	tic_init, @function
tic_init:
	addi     sp, sp, -4
	sw       (sp+4), ra
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	ori      r2, r0, 50000
	sw       (r1+4), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 0
	sw       (r1+8), r2
	orhi     r1, r0, hi(timer0)
	ori      r1, r1, lo(timer0)
	lw       r1, (r1+0)
	addi     r2, r0, 14
	sw       (r1+0), r2
	lw       ra, (sp+4)
	addi     sp, sp, 4
	b        ra
	.size	tic_init, .-tic_init
	.align 4
	.global	uart_init
	.type	uart_init, @function
uart_init:
	addi     sp, sp, -4
	sw       (sp+4), ra
	lw       ra, (sp+4)
	addi     sp, sp, 4
	b        ra
	.size	uart_init, .-uart_init
	.align 4
	.global	uart_getchar
	.type	uart_getchar, @function
uart_getchar:
	addi     sp, sp, -4
	sw       (sp+4), ra
	nop
.L6:
	orhi     r1, r0, hi(uart0)
	ori      r1, r1, lo(uart0)
	lw       r1, (r1+0)
	lw       r1, (r1+0)
	andi     r2, r1, 1
	addi     r1, r0, 0
	be     r2,r1,.L6
	orhi     r1, r0, hi(uart0)
	ori      r1, r1, lo(uart0)
	lw       r1, (r1+0)
	lw       r1, (r1+4)
	andi     r1, r1, 0xff
	lw       ra, (sp+4)
	addi     sp, sp, 4
	b        ra
	.size	uart_getchar, .-uart_getchar
	.align 4
	.global	uart_putchar
	.type	uart_putchar, @function
uart_putchar:
	addi     sp, sp, -8
	sw       (sp+4), ra
	sb       (sp+8), r1
	nop
.L8:
	orhi     r1, r0, hi(uart0)
	ori      r1, r1, lo(uart0)
	lw       r1, (r1+0)
	lw       r1, (r1+0)
	andi     r2, r1, 16
	addi     r1, r0, 0
	bne    r2,r1,.L8
	orhi     r1, r0, hi(uart0)
	ori      r1, r1, lo(uart0)
	lw       r1, (r1+0)
	lbu      r2, (sp+8)
	sw       (r1+4), r2
	lw       ra, (sp+4)
	addi     sp, sp, 8
	b        ra
	.size	uart_putchar, .-uart_putchar
	.align 4
	.global	uart_putstr
	.type	uart_putstr, @function
uart_putstr:
	addi     sp, sp, -12
	sw       (sp+4), ra
	sw       (sp+8), r1
	lw       r1, (sp+8)
	sw       (sp+12), r1
	bi       .L10
.L11:
	lw       r1, (sp+12)
	lbu      r1, (r1+0)
	calli    uart_putchar
	lw       r1, (sp+12)
	addi     r1, r1, 1
	sw       (sp+12), r1
.L10:
	lw       r1, (sp+12)
	lbu      r2, (r1+0)
	addi     r1, r0, 0
	bne    r2,r1,.L11
	lw       ra, (sp+4)
	addi     sp, sp, 12
	b        ra
	.size	uart_putstr, .-uart_putstr
	.ident	"GCC: (GNU) 4.5.2 20101208 (prerelease)"
