	.data

texto0:	.asciiz "ingrese su edad \n"
texto1:	.asciiz "."
texto2: .asciiz ".."

	.text	
	.globl main

main:
	la $a0,texto0
	syscall
	li $v0,5
	syscall
	move $t0,$v0
	la $v0, 1
	syscall	

	la $a0,texto0
	syscall
	la $a0,texto1
	syscall
	la $a0,texto2
	syscall
fin:	jr $ra      # Retorna al programa principal
