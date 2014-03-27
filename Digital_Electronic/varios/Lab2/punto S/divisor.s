.global	main
.type	main, @function
main:
addi r2, r0, 10	// Equivalencias de registros
sw (fp+0), r2	//r1=a concatenación entre A y Q
addi r3, r0, 2 //r2=Q	Dividendo
sw (fp+2), r3	//r3=d	divisor
addi r5, r0, 32 //r4=A	registro auxiliar
sw (fp+4), r5	//r5=n	# de bits
addi r8, r0, 1 //r6=Qo
sw (fp+6), r8	//r7=Cont contador
addi r7, r0, 0	//r8=1	registro auxiliar
sw (fp+8), r7
addi r4, r0, 0
sw (fp+10), r4
addi r8, r0, 1
sw (fp+12), r8
add r1, r4, r2
.loop sli r1, r1, 1
sli r2, r2, 1
sub r4, r1, r3
bne	 r4, r5, 1
mvhi	 r6, 0
add r4, r4, r3
mvhi	 r6, 1
sub	 r5, r5, r8
be r7, r8, 1
bi .done
addi r7, r7, 1
bi .loop
.done
.size	main, .-main
