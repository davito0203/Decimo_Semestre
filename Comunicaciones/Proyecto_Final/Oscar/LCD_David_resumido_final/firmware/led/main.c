/**
 *Blinker led
 *
 *
 */
#include "soc-hw.h"

/* prototypes */


int main ()
{


uint32_t a=1;
//uint32_t dato;
	
uint32_t estado=0;
uint32_t cont=1;

while(1){

if(t()==a){

////inicio

switch(estado){
case 0:lcd_iniciar(cont);
	cont=cont+1;
	if(cont==4)estado=estado+1;
	break;
case 1: titulo(cont);
	cont=cont+1;
	if(cont==14)estado=estado+1;
	break;
case 2: espacio1(cont);
	cont=cont+1;
	if (cont==15)estado=estado+1;
	break;
case 3: titulo1(cont);
	cont=cont+1;
	if (cont==21)estado=estado+1;
	break;
default: if (cont==21) 
	cont=21;
	break;

}
//////





//////enviar dato adc a matlab/////////////////
///////////////////////////////////////
/////el dato se envia cada segundo pero no 
/////creo que tenga algun problema, para matlab ha de ser indiferente
/////cada cuanto cambia el dato
//dato=(char)traer();

//uart_putchar(dato);
/////////////////////////////////////////////
a=0;
}


if(t()==0) a=1;

}
return 0;

}

