# Este programa suma dos números ubicados en memoria y guarda
# el resultado en memoria, pero además lo muestra por pantalla.
	.data
num_a: .word 78
num_b: .word 2
result: .word 0
cad0: .asciiz "La suma de "
cad1: .asciiz " y "
cad2: .asciiz " es "
	.text	
	.globl main
main:
	lw $t0,num_a # Cargamos el valor de num_b en t0
	lw $t1,num_b # Cargamos el valor de num_b en t1
	add $t2,$t0,$t1 # Guardamos la suma de t0 y t1 en t2
	sw $t2,result # Almacenamos t2 en la direccion result

	li $v0,4  # Estas tres líneas de código imprimen la cadena cad0
	la $a0,cad0
	syscall
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,cad1
	syscall
	li $v0,1 # Estas tres líneas de código imprimen el entero almacenado en t1
	move $a0,$t1
	syscall
	li $v0,4
	la $a0,cad2
	syscall
	li $v0,1
	move $a0,$t2
	syscall
fin:	jr $ra# Retorna al programa principal


