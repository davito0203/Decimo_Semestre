

addi r1, r1, 0xA		//dividendo
addi r2, r2, 0x5		//divisor
addi r3, r3, 4		        //Numero bits
addi r4, r4, 0
addi r5, r5, 0
addi r6, r6, 1


.move:
	sli r4, r1, 4		//mover A 4 posiciones a la izq
	sli r1, r1, 1		//mover
	sub r4, r4, r2		//realiza la resta
 
	bg r3, r4, .menor	//si es menor que 0
	bge r3, r4, .mayor	//si mayor que 0
 
.menor:
	xor r7, r7, r7  	//menos significaticvo =0
	add r4, r4, r3	//restaurta valor
	bi .sumar		//sumar
 
.mayor:
	or r7, r7, 1		//menos significativo=1
 
.sumar:
	sli r2, r2, 1		//corrimento izquiera del cociente
	add r4, r4, r7
 
	be r4, r3, .fin	//si se realizo los 4 bits
	bi .mover		// sino ir a mover
 
.fin:
	ori r6, r6, 1		//final
