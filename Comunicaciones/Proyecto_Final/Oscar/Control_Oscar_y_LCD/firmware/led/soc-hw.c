#include "soc-hw.h"

/* espacios de memoria que se pueden utilizar

uart_t  	*uart0  =     (uart_t *)   	0xF0000000;
timer_t 	*timer0  =    (timer_t *)       0xFF010000;
gpio_t 	      	*gpio0  =     (gpio_t *)   	0xFF020000;
lcd2_t	  	*lcd20  =     (lcd2_t *)    	0xFF030000;
lcd_t  		*lcd0   =     (lcd_t *)    	0xFF040000;
ecual_t    	*ecual0 =     (ecual_t *)  	0XFF060000;
pwm_t	  	*pwm0  	=     (pwm_t *)    	0xFF050000;

*/

//uart_t   *uart0  = (uart_t *)   0x20000000;
perifericos_t  *perifericos0 = (perifericos_t *)  0xFF030000;
timer_t  *timer0 = (timer_t *)  0x40000000;// 0x40000000;
//gpio_t   *gpio0  = (gpio_t *)   0x60000000;
// uint32_t *sram0  = (uint32_t *) 0x40000000;
//lcd_t   *lcd0  = (lcd_t *)   0x80000000;

//uint32_t msec = 0;

/***************************************************************************
 * General utility functions
 */
/*
void sleep(int msec)
{
	uint32_t tcr;

	// Use timer0.1
	timer0->compare1 = (FCPU/1000)*msec;
	timer0->counter1 = 0;
	timer0->tcr1 = TIMER_EN | TIMER_IRQEN;

	do {
		//halt();
 		tcr = timer0->tcr1;
 	} while ( ! (tcr & TIMER_TRIG) );
}

void tic_init()
{
	// Setup timer0.0
	timer0->compare0 = (FCPU/1000);
	timer0->counter0 = 0;
	timer0->tcr0     = TIMER_EN | TIMER_AR | TIMER_IRQEN;
}
*/


////////////AQUI FUNCIONES DE OSCAR////////////////////////////
int Cancion_Select(int Tecla){////////////////////Cancion_Select()

int Cancion=0;

switch(Tecla) {			//ojo con los break
case 25: if (Cancion<4) {
		Cancion= Cancion+1;
	  } else Cancion=Cancion;
	break;
case 26: if (Cancion>0){
	Cancion= Cancion-1;
	  } else Cancion=Cancion;
	break;
default: Cancion=Cancion;
}

return Cancion;
} ///////////////////////////////////////////fin Cancion_Select()


int Nivel_Select(int Tecla){////////////////////Nivel_Select()

int Nivel=0;   //ojo con si lo ejecuta siempre

switch(Tecla) {			//ojo con los break
case 25: if (Nivel<1) {
		Nivel= Nivel+1;
	  } else Nivel=Nivel;
	break;
case 26: if (Nivel>0){
	Nivel= Nivel-1;
	  } else Nivel=Nivel;
	break;
default: Nivel=Nivel;
}

return Nivel;
} ///////////////////////////////////////////fin Nivel_Select()


int Led_Select(int Temp_Nivel){////////////////////Led_Select()

int Led=1;   //ojo con si lo ejecuta siempre

switch(Temp_Nivel) {			//ojo con los break
case 0: Led= 1;
	break;
case 1: Led= 0;
	break;
default: Led=Led;
}

return Led;
} ///////////////////////////////////////////fin Led_Select()


int Select_OV(int Tecla){////////////////////Select_OV()

int OV=0;   //ojo con si lo ejecuta siempre

switch(Tecla) {			//ojo con los break
case 26: OV= 0;//si
	break;
case 25: OV= 1;//no
	break;
default: OV=OV;
}

return OV;
} ///////////////////////////////////////////fin Select_OV()

// falta revisar sincronizmo --- actualizacion de variables



//////////////////////////////////////DAVID///////////////////


uint32_t t(){

return timer0->ledo;
}
//////////////////////////////////////LCD

void lcd_iniciar(int c_inicio){
timer0->E=1;
timer0->RS=0;
timer0->RW=0;
switch(c_inicio){
case 1: timer0->Data_out=0x0c; break;	
case 2: timer0->Data_out=0x38;break;	
case 3: timer0->Data_out=0x01;break;	//Borrar pantalla
case 4: timer0->Data_out=0x80;break;   	//Direccion a apuntar direccion 1 linea 1
					//Del caso 1 al 3
}}

void lcd_linea2(int c_linea2){
timer0->E=1;
timer0->RS=0;
timer0->RW=0;
switch(c_linea2){
case 21: timer0->Data_out=0xc0;break;   	//Direccion a apuntar direccion 1 linea 2
	}				//Del caso 1 al 3
}

//  Titulo proyecto 


void titulo1(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){
case 5:  timer0->Data_out=0x20;break;	//_	01
case 6:  timer0->Data_out=0x20;break;	//_	02
case 7:  timer0->Data_out=0x20;break;	//_	03
case 8:  timer0->Data_out=0x20;break;	//_	04
case 9:  timer0->Data_out=0x20;break;	//_	05
case 10:  timer0->Data_out=0x4b;break;	//K	06
case 11:  timer0->Data_out=0x45;break;	//E	07
case 12:  timer0->Data_out=0x59;break;	//Y	08 
case 13:  timer0->Data_out=0x20;break;	//_	09
case 14:  timer0->Data_out=0x50;break;	//P	10
case 15:  timer0->Data_out=0x49;break;	//I	11
	}
}

//					check

// Mensaje cancion 1

void song(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){

case 5:  timer0->Data_out=0x20;break;	//_
case 6:  timer0->Data_out=0x4e;break;	//N
case 7:  timer0->Data_out=0x4f;break;	//O
case 8:  timer0->Data_out=0x4d;break;	//M
case 9:  timer0->Data_out=0x42;break;	//B
case 10:  timer0->Data_out=0x52;break;	//R
case 11:  timer0->Data_out=0x45;break;	//E
case 12:  timer0->Data_out=0x20;break;	//ESPACIO
case 13:  timer0->Data_out=0x43;break;	//C
case 14:  timer0->Data_out=0x41;break;	//A
case 15:  timer0->Data_out=0x4e;break;	//N
case 16:  timer0->Data_out=0x43;break;	//C
case 17:  timer0->Data_out=0x49;break;	//I
case 18:  timer0->Data_out=0x4f;break;	//O
case 19:  timer0->Data_out=0x4e;break;	//N
case 20:  timer0->Data_out=0x20;break;	//_

}}

void song1(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){

case 22:  timer0->Data_out=0x3c;break;	//<
case 23:  timer0->Data_out=0x31;break;	//1
case 24:  timer0->Data_out=0x3e;break;	//>

}}

// Cancion 2

void song2(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){

case 22:  timer0->Data_out=0x3c;break;	//<
case 23:  timer0->Data_out=0x32;break;	//2
case 24:  timer0->Data_out=0x3e;break;	//>

}
}

//Cancion 3

void song3(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){

case 22:  timer0->Data_out=0x3c;break;	//<
case 23:  timer0->Data_out=0x33;break;	//3
case 24:  timer0->Data_out=0x3e;break;	//>


}
}

// Cancion 4

void song4(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){

case 22:  timer0->Data_out=0x3c;break;	//<
case 23:  timer0->Data_out=0x34;break;	//4
case 24:  timer0->Data_out=0x3e;break;	//>

}
}

//Cancion 5

void song5(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){


case 22:  timer0->Data_out=0x3c;break;	//<
case 23:  timer0->Data_out=0x35;break;	//5
case 24:  timer0->Data_out=0x3e;break;	//>

}
}

// Elegir nivel 

void elige(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){

case 5:  timer0->Data_out=0x20;break;	//_
case 6:  timer0->Data_out=0x20;break;	//_
case 7:  timer0->Data_out=0x45;break;	//E
case 8:  timer0->Data_out=0x4c;break;	//L
case 9:  timer0->Data_out=0x49;break;	//I
case 10:  timer0->Data_out=0x47;break;	//G
case 11:  timer0->Data_out=0x45;break;	//E
case 12:  timer0->Data_out=0x20;break;	//ESPACIO
case 13:  timer0->Data_out=0x20;break;	//ESPACIO
case 14:  timer0->Data_out=0x4e;break;	//N
case 15:  timer0->Data_out=0x49;break;	//I
case 16:  timer0->Data_out=0x56;break;	//V
case 17:  timer0->Data_out=0x45;break;	//E
case 18:  timer0->Data_out=0x4c;break;	//L
case 19:  timer0->Data_out=0x20;break;	//_
case 20:  timer0->Data_out=0x20;break;	//_
default: timer0->Data_out=0x00;
	}
}

//NIvel normal

void normal(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){

case 22:  timer0->Data_out=0x3c;break;	//<
case 23:  timer0->Data_out=0x31;break;	//1
case 24:  timer0->Data_out=0x3e;break;	//>

}}

// Experto 

void experto(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){

case 22:  timer0->Data_out=0x3c;break;	//<
case 23:  timer0->Data_out=0x32;break;	//2
case 24:  timer0->Data_out=0x3e;break;	//>

}
}

// Escuchar:

void escuchar(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){

case 5:  timer0->Data_out=0x45;break;	//E
case 6:  timer0->Data_out=0x53;break;	//S
case 7:  timer0->Data_out=0x43;break;	//C
case 8:  timer0->Data_out=0x55;break;	//U
case 9:  timer0->Data_out=0x43;break;	//C
case 10:  timer0->Data_out=0x48;break;	//H
case 11:  timer0->Data_out=0x41;break;	//A
case 12:  timer0->Data_out=0x21;break;	//!

	}
}

// Preparado:

void preparado(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){

case 5:  timer0->Data_out=0x50;break;	//P
case 6:  timer0->Data_out=0x52;break;	//R
case 7:  timer0->Data_out=0x45;break;	//E
case 8:  timer0->Data_out=0x50;break;	//P
case 9:  timer0->Data_out=0x41;break;	//A
case 10:  timer0->Data_out=0x52;break;	//R
case 11:  timer0->Data_out=0x41;break;	//A
case 12:  timer0->Data_out=0x44;break;	//D
case 13:  timer0->Data_out=0x4f;break;	//O
case 14:  timer0->Data_out=0x21;break;	//!

	}
}

// Adelante:

void adelante(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){

case 5:  timer0->Data_out=0x41;break;	//A
case 6:  timer0->Data_out=0x44;break;	//D
case 7:  timer0->Data_out=0x45;break;	//E
case 8:  timer0->Data_out=0x4c;break;	//L
case 9:  timer0->Data_out=0x41;break;	//A
case 10:  timer0->Data_out=0x4e;break;	//N
case 11:  timer0->Data_out=0x54;break;	//T
case 12:  timer0->Data_out=0x45;break;	//E
case 13:  timer0->Data_out=0x21;break;	//!
case 14:  timer0->Data_out=0x21;break;	//!

	}
}

// otra vez

void again(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){

case 5:  timer0->Data_out=0x20;break;	//_
case 6:  timer0->Data_out=0x20;break;	//_
case 7:  timer0->Data_out=0x20;break;	//_
case 8:  timer0->Data_out=0x4f;break;	//O
case 9:  timer0->Data_out=0x54;break;	//T
case 10:  timer0->Data_out=0x52;break;	//R
case 11:  timer0->Data_out=0x41;break;	//A
case 12:  timer0->Data_out=0x20;break;	//_
case 13:  timer0->Data_out=0x56;break;	//V
case 14:  timer0->Data_out=0x45;break;	//E
case 15:  timer0->Data_out=0x5a;break;	//Z
case 16:  timer0->Data_out=0x20;break;	//_
case 17:  timer0->Data_out=0x3f;break;	//?
case 18:  timer0->Data_out=0x20;break;	//_
case 19:  timer0->Data_out=0x20;break;	//_
case 2:  timer0->Data_out=0x20;break;	//_

	}
}

//SI

void si(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){

case 22:  timer0->Data_out=0x3c;break;	//<
case 23:  timer0->Data_out=0x53;break;	//S
case 24:  timer0->Data_out=0x49;break;	//I
case 25:  timer0->Data_out=0x3e;break;	//>

	}
}

// otra vez no:

void no(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){


case 22:  timer0->Data_out=0x3c;break;	//<
case 23:  timer0->Data_out=0x4e;break;	//N
case 24:  timer0->Data_out=0x4f;break;	//O
case 25:  timer0->Data_out=0x3e;break;	//>

	}
}



void Vis_LCD ( volatile uint32_t Estado_LCD, volatile uint32_t AUX_LCD)
{

//volatile uint32_t Estado_LCD;
//volatile uint32_t AUX_LCD;


//Variable para el switch del E
uint8_t a=1;

//Estados de inicializacion y escritura	
uint8_t estado_0=0;
uint8_t estado_1=0;
uint8_t estado_2=0;
uint8_t estado_3=0;
uint8_t estado_4=0;
uint8_t estado_5=0;
uint8_t estado_6=0;


//Contador de instrucciones LCD
uint8_t cont_0=1;
uint8_t cont_1=1;
uint8_t cont_2=1;
uint8_t cont_3=1;
uint8_t cont_4=1;
uint8_t cont_5=1;
uint8_t cont_6=1;

while(1){

if(t()==a){

////inicio

switch(Estado_LCD){ // corchete Estado_LCD

	// Bienvenido Key_PI
	
	case 0: //case 0 Estado_LCD

	switch(estado_0){		//switch(estado_0)
	
	case 0: lcd_iniciar(cont_0);
	cont_0=cont_0+1;
	if(cont_0==5)estado_0=estado_0+1;
	break; //break del case 0

	case 1: titulo1(cont_0);
	cont_0=cont_0+1;
	if(cont_0==16)estado_0=estado_0+1;
	break; //break del case 1

	
	default: if (cont_0==16)
		cont_0=16;

	}	// end switch(estado_0)

	break;  //break case 0 Estado_LCD

	// Elegir cancion 

	case 1://case 1 Estado_LCD

	switch (estado_1) { // 	//switch(estado_1)

	case 0: lcd_iniciar(cont_1);
	cont_1=cont_1+1;
	if(cont_1==5)estado_1=estado_1+1;
	break; //break del case 0

	case 1: song(cont_1);
	cont_1=cont_1+1;
	if(cont_1==21)estado_1=estado_1+1;
	break; //break del case 1

	case 2:	lcd_linea2(cont_1);
	cont_1=cont_1+1;
	if(cont_1==22)estado_1=estado_1+1;
	break; //break del case 2

	case 3:
	
	switch(AUX_LCD){
	
	case 0:	song1(cont_1);		//cancion 1
	cont_1=cont_1+1;
	if(cont_1==25)estado_1=estado_1+1;	
	break; //0
	
	case 1: song2(cont_1);		//cancion 2
	cont_1=cont_1+1;
	if(cont_1==25)estado_1=estado_1+1;	
	break; //1

	case 2:	song3(cont_1);		//cancion 3
	cont_1=cont_1+1;
	if(cont_1==25)estado_1=estado_1+1;	
	break; //2

	case 3:	song4(cont_1);		//cancion 4
	cont_1=cont_1+1;
	if(cont_1==25)estado_1=estado_1+1;	
	break;	//3

	case 4:	song5(cont_1);		//cancion 5
	cont_1=cont_1+1;
	if(cont_1==25)estado_1=estado_1+1;	
	break;	//4

	default: if (cont_1==25)
		cont_1=25;
	
} // End switch AUX_LCD

	break;	//break del case 3


} 	//switch(estado_1)
	
	break; //break case 1 Estado_LCD

//
	//Case 2 Elegir nivel
	case 2: //case 2 Estado_LCD

	switch (estado_2) { // 	//switch(estado_2)

	case 0: lcd_iniciar(cont_2);
	cont_2=cont_2+1;
	if(cont_2==5)estado_2=estado_2+1;
	break; //break del case 0

	case 1: elige(cont_2);
	cont_2=cont_2+1;
	if(cont_2==21)estado_2=estado_2+1;
	break; //break del case 1

	case 2:	lcd_linea2(cont_2);
	cont_2=cont_2+1;
	if(cont_2==22)estado_2=estado_2+1;
	break; //break del case 2

	case 3:
	
	switch(AUX_LCD){
	
	case 0: normal(cont_2);
	cont_2=cont_2+1;
	if(cont_2==25)estado_2=estado_2+1;
	
	break; //break del case 0 normal()
	
	case 1: experto(cont_2);
	cont_2=cont_2+1;
	if(cont_2==25)estado_2=estado_2+1;
	break; //break del case 1 experto

	default: if (cont_2==25)
		cont_2=25;

	} //end switch AUX_LCD

	break;	//break del case 3

	} //end switch(estado_2)


	break; // break //case 2 Estado_LCD

	//

	//Escuchar

// Escuchar cancion
	case 3: //case 3 Estado_LCD

	switch(estado_3){		//switch(estado_3)	
	
	case 0: lcd_iniciar(cont_3);
	cont_3=cont_3+1;
	if(cont_3==5)estado_3=estado_3+1;
	break; //break del case 0

	case 1: escuchar(cont_3);
	cont_3=cont_3+1;
	if(cont_3==13)estado_3=estado_3+1;
	break; //break del case 1

	default: if (cont_3==13)
		cont_3=13;

	}	//end //switch(estado_3)	
	
	break;//case 3 Estado_LCD

// Preparado?????????????''''''

	case 4: //case 4 Estado_LCD

	switch(estado_4){		//switch(estado_4)	
	
	case 0: lcd_iniciar(cont_4);
	cont_4=cont_4+1;
	if(cont_4==5)estado_4=estado_4+1;
	break; //break del case 0

	case 1: preparado(cont_4);
	cont_4=cont_4+1;
	if(cont_4==14)estado_4=estado_4+1;
	break; //break del case 1

	default: if (cont_4==14)
		cont_4=14;

	}	//end //switch(estado_4)	
	
	break;//case 4 Estado_LCD

// Adelante

	case 5: //case 5 Estado_LCD

	switch(estado_5){		//switch(estado_5)	
	
	case 0: lcd_iniciar(cont_5);
	cont_5=cont_5+1;
	if(cont_5==5)estado_5=estado_5+1;
	break; //break del case 0

	case 1: adelante(cont_5);
	cont_5=cont_5+1;
	if(cont_5==14)estado_5=estado_5+1;
	break; //break del case 1

	default: if (cont_5==14)
		cont_5=14;

	}	//end //switch(estado_5)	
	
	break;//case 5 Estado_LCD

//Again
	case 6: //case 6 Estado_LCD

	switch (estado_6) { // 	//switch(estado_6)

	case 0: lcd_iniciar(cont_6);
	cont_6=cont_6+1;
	if(cont_6==5)estado_6=estado_6+1;
	break; //break del case 0

	case 1: again(cont_6);
	cont_6=cont_6+1;
	if(cont_6==21)estado_6=estado_6+1;
	break; //break del case 1

	case 2:	lcd_linea2(cont_6);
	cont_6=cont_6+1;
	if(cont_6==22)estado_6=estado_6+1;
	break; //break del case 2

	case 3:
	
	switch(AUX_LCD){
	
	case 0: si(cont_6);
	cont_6=cont_6+1;
	if(cont_6==26)estado_6=estado_6+1;
	
	break; //break del case 0 normal()
	
	case 1: no(cont_6);
	cont_6=cont_6+1;
	if(cont_6==26)estado_6=estado_6+1;
	break; //break del case 1 experto

	default: if (cont_6==26)
		cont_6=26;

	} //end switch AUX_LCD

	break;	//break del case 3

	} //end switch(estado_6)


	break; // break //case 6 Estado_LCD

	default: if (cont_6==0)
		cont_6=0;



//

} //corchete Estado_LCD
//fin del switch estado LCD
a=0;
	}


if(t()==0) a=1;

	}



//return 0;

}	//end main




///////////////////////////////DAVID////////////////////////////





/*
//AQUI LAS FUNCIONES QUE UTILIZA DAVID
uint32_t t(){

return timer0->ledo;
}
//////////////////////////////////////LCD



void lcd_iniciar(int c_inicio){
timer0->E=1;
timer0->RS=0;
timer0->RW=0;
switch(c_inicio){
case 1: timer0->Data_out=0x0f; break;	
case 2: timer0->Data_out=0x38;break;	
case 3: timer0->Data_out=0x83;break;   	//Direccion a apuntar
					//Del caso 1 al 3
}}



void titulo(int paso){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso){
case 4:  timer0->Data_out=0x42;break;	//B
case 5:  timer0->Data_out=0x49;break;	//I
case 6:  timer0->Data_out=0x45;break;	//E
case 7:  timer0->Data_out=0x4e;break;	//N
case 8:  timer0->Data_out=0x56;break;	//V
case 9: timer0->Data_out=0x45;break;	//E
case 10: timer0->Data_out=0x4e;break;	//N
case 11: timer0->Data_out=0x49;break;	//I
case 12: timer0->Data_out=0x44;break;	//D
case 13: timer0->Data_out=0x4f;break;	//O
					//Del caso 4 al 13

}}

void espacio1(int esp){
timer0->E=1;
timer0->RS=0;
timer0->RW=0;
switch(esp){
case 14: timer0->Data_out=0xc5; break;	
  				//Direccion a apuntar Caso 14
}}

void titulo1(int paso1){

timer0->E=1;
timer0->RS=1;
timer0->RW=0;

switch(paso1){
case 15:  timer0->Data_out=0x4b;break;	//K
case 16:  timer0->Data_out=0x45;break;	//E
case 17:  timer0->Data_out=0x59;break;	//Y 
case 18:  timer0->Data_out=0xb0;break;	//-
case 19:  timer0->Data_out=0x50;break;	//P
case 20:  timer0->Data_out=0x49;break;	//I

					//Del caso 4 al 13

}}
*/
/*
void tem(int dato,int cont){
int unidad=0;
int decena=0;
int dato1=0;
int numd=0;
int num2=0;

dato1=dato;

while(dato1>9) {dato1=dato1-10;numd=numd+1;}
while(numd>9) {numd=numd-10;num2=num2+1;}

unidad=numd+48;
decena=num2+48;

timer0->E=1;

switch(cont){

case 17:timer0->RS=0;
	timer0->RW=0;
	timer0->Data_out=0xcd;break;

case 18:timer0->RS=1;
	timer0->RW=0;
	timer0->Data_out=decena;break;
case 19:timer0->RS=1;
	timer0->RW=0;
	timer0->Data_out=unidad;break;
case 20:timer0->RS=1;
	timer0->RW=0;
	timer0->Data_out=0xdf;break;


}}
*/



//////////////////////////////////77
/***************************************************************************
 * UART Functions
 */
//void uart_init()
//{
	//uart0->ier = 0x00;  // Interrupt Enable Register
	//uart0->lcr = 0x03;  // Line Control Register:    8N1
	//uart0->mcr = 0x00;  // Modem Control Register

	// Setup Divisor register (Fclk / Baud)
	//uart0->div = (FCPU/(57600*16));
//}

//char uart_getchar()
//{   
//	while (! (uart0->ucr & UART_DR)) ;
//	return uart0->rxtx;
//}

//void uart_putchar(char c)
//{
//	while (uart0->ucr & UART_BUSY) ;
//	uart0->rxtx = c;
//}

//void uart_putstr(char *str)
//{
//	char *c = str;
//	while(*c) {
//		uart_putchar(*c);
//		c++;
//	}
//}

///////////////traer dato del gpio
//uint32_t traer(){


//return gpio0->gpio_in;

//}
