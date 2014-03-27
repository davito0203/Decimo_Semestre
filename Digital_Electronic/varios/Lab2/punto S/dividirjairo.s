# División de dos números enteros, generando el residuo y el cociente

.data  # declaracin de variables

mensaje1:   .asciiz "Ingrese el dividendo:\n"
mensaje2:   .asciiz "Ingrese el divisor:\n"
mensaje3:   .asciiz "Cociente:\n"
mensaje4:   .asciiz "\nResiduo:\n"

.text

.globl main

main:
	li $v0, 4	#ingreso del system call code para imprimir  
	la $a0, mensaje1
	syscall
	li $v0, 5	#ingreso del system call code leer
	syscall
	move $s0, $v0	#almacenamos el dividendo en $s0
	li $v0, 4	#ingreso del system call code para imprimir  
	la $a0, mensaje2	
	syscall
	li $v0, 5	#ingreso del system call code para leer
	syscall
	move $s1, $v0	#almacenamos el divisor en $s1

#	li $a0, 24501		#fijamos y almacenamos el dividendo en $a0	
#	li $a1, 100		#fijamos y almacenamos el divisor en $a1	
	move $a0, $s0
	move $a1, $s1
	li $t0, 0		#el contador del No de repeticiones del ciclo en $t0
	li $v0, 0		#el residuo en $v0
	li $v1, 0		#el cociente en $v1
	beqz $a1, exit		#si el divisor es 0 sale del código
	b comparar		#salto incondicional 

comparar: 
	sle $t1, $a1, $v0	#mirar si divisor <= residuo 
	beq $t1, 1, restar	#salta a restar si cumple
	sll $v1, $v1, 1		#desplaza cociente
	b contar

restar:
	sub $v0, $v0, $a1 	#R=R-D
	sll $v1, $v1, 1
	addi $v1, $v1,1
	b contar 

contar:
	addi $t0, $t0, 1	#aumentamos el contador
	beq $t0, 33, resultado	#comparar si el cont$v0,ador es 32
	sll $t2, $a0, 1		#averiguamos cual es el valor del MSB del dividendo y lo colocamos en el LSB del residuo
	srl $t2, $t2, 1
	sll $v0, $v0, 1
	bne $t2, $a0, sumar1
	sll $a0, $a0, 1
	b exitif	
sumar1:
	addi $v0, $v0, 1
	sll $a0, $a0, 1
exitif:
	b comparar

resultado:
	move $s2, $v0 	# almacenamos el residuo
	move $s3, $v1 	# almacenamos el cociente
	li $v0, 4	#ingreso del system call code para imprimir  
	la $a0, mensaje3
	syscall
	li $v0, 1	#ingreso del system call code para imprimir  
	move $a0, $s3
	syscall	
	li $v0, 4	#ingreso del system call code para imprimir  
	la $a0, mensaje4
	syscall
	li $v0, 1	#ingreso del system call code para imprimir  
	move $a0, $s2
	syscall	
	b exit
exit:
	jr $ra
# END OF PROGRAM

