	.data

texto0:	.asciiz "Hola mundo!!! \n"
texto1:	.asciiz "Unal \n"
texto2: .asciiz "2012-I \n"

	.text	
	.globl main

main:
	la $a0,texto0
	syscall
	la $a0,texto1
	syscall
	la $a0,texto2
	syscall
fin:	jr $ra      
