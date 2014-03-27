//CONTROL CENTRAL
 
#include "soc-hw.h"

int main ()
{
//entradas

volatile uint32_t Tecla=timer0->Tecla;
volatile uint32_t Fin_Cancion=timer0->Fin_Cancion;
// salidas: señales de control de perifericos
volatile uint32_t En_S_Us=0;
volatile uint32_t LEDs_ON=0;
volatile uint32_t Melodia_ON=0;
volatile uint32_t En_Mem=0;
volatile uint32_t Rst_Mem=1;
volatile uint32_t Cancion=0;
volatile uint32_t Estado_LCD=0;
volatile uint32_t AUX_LCD=0;

//varialbes internas
volatile uint32_t estado=0;
//registros temporales
volatile uint32_t Temp_Nivel=0;
volatile uint32_t Temp_OV=1;
//registros constantes
	//uint32_t Adelate=25;
	//uint32_t Atras=26;
uint32_t Play=27;
uint32_t Stop=28;


while (1){

//Definicion de estados
switch (estado){

case 0: timer0->En_S_Us=0; 	//estado bienvenidos Key PI
	timer0->LEDs_ON=0;
	timer0->Melodia_ON=0;
	timer0->En_Mem=0;
	timer0->Rst_Mem=1;
	timer0->Cancion=0;
	timer0->Estado_LCD=0;
	timer0->AUX_LCD=0;
	break;

case 1: timer0->En_S_Us=1;	//estado elija cancion
	timer0->LEDs_ON=1;
	timer0->Melodia_ON=0;
	timer0->En_Mem=0;
	timer0->Rst_Mem=1;
	timer0->Cancion= Cancion_Select(Tecla) ;
	timer0->Estado_LCD=1;
	timer0->AUX_LCD=Cancion_Select(Tecla) ;
	break;

case 2: timer0->En_S_Us=0;	//estado elija Nivel
	timer0->LEDs_ON=0;
	timer0->Melodia_ON=0;
	timer0->En_Mem=0;
	timer0->Rst_Mem=1;
	timer0->Cancion=Cancion;
	timer0->Estado_LCD=2;
	timer0->AUX_LCD= Nivel_Select(Tecla);

	Temp_Nivel= Nivel_Select(Tecla);
	break;

case 3: timer0->En_S_Us=0;	// estado Escucha
	timer0->LEDs_ON= Led_Select(Temp_Nivel);
	timer0->Melodia_ON=1;
	timer0->En_Mem=1;
	timer0->Rst_Mem=0;
	timer0->Cancion=Cancion;
	timer0->Estado_LCD=3;
	timer0->AUX_LCD=AUX_LCD;
	break;

case 4: timer0->En_S_Us=0;	// estado Preparado
	timer0->LEDs_ON=0;
	timer0->Melodia_ON=0;
	timer0->En_Mem=0;
	timer0->Rst_Mem=1;
	timer0->Cancion=Cancion;
	timer0->Estado_LCD=4;
	timer0->AUX_LCD=AUX_LCD;
	break;

case 5: timer0->En_S_Us=1;	// estado: adelante!!!
	timer0->LEDs_ON=Led_Select(Temp_Nivel);
	timer0->Melodia_ON=0;
	timer0->En_Mem=1;
	timer0->Rst_Mem=0;
	timer0->Cancion=Cancion;
	timer0->Estado_LCD=5;
	timer0->AUX_LCD=AUX_LCD;
	break;

case 6: timer0->En_S_Us=0;	// estado: ¿otra vez?
	timer0->LEDs_ON=0;
	timer0->Melodia_ON=0;
	timer0->En_Mem=0;
	timer0->Rst_Mem=1;
	timer0->Cancion=Cancion;
	timer0->Estado_LCD=6;
	timer0->AUX_LCD=Select_OV(Tecla);

	Temp_OV= Select_OV(Tecla);
	break;

default:timer0->En_S_Us=0; 	//Por default: estado bienvenidos Key PI
	timer0->LEDs_ON=0;
	timer0->Melodia_ON=0;
	timer0->En_Mem=0;
	timer0->Rst_Mem=1;
	timer0->Cancion=0;
	timer0->Estado_LCD=0;
	timer0->AUX_LCD=0;

}


//definicion de transicion entre estados REVISAR ESTADO y NESTADO
switch (estado){

	case 0: if (Tecla==Play) {
			estado=1;
			}else {
			       estado=estado;
			       }
			 //msleep(50000);
			 //estado=1;
		break;

	case 1: if (Tecla==Play) {
			estado=2;
			}
			else if(Tecla==Stop){
				estado=0;
				}
				else{ 
				     estado= estado;
				     }
		break;


	case 2:	if (Tecla==Play) {
			estado=3;
			}
			else if(Tecla==Stop){
				estado=1;
				}
				else{ 
				     estado= estado;
				     }
		break;


	case 3:	if (Fin_Cancion==1) {
			estado=4;
			}
			else if(Tecla==Stop){
				estado=2;
				}
				else{ 
				     estado= estado;
				     }
		break;


	case 4: if (Tecla==Stop) { //ojo actualizar tecla!!!
			estado=2;
			}
			else {
			     //msleep(3000); 
			     estado= 5;
			     }
		break;


	case 5:	if (Tecla==Stop) {
			estado=2;
			}
			else if(Fin_Cancion==1){
				estado=6;
				}
				else{ 
				     estado= estado;
				     }
		break;


	case 6:	if ((Tecla==Play) && (Temp_OV=0)){ //TempOV=0 es SI
			estado=3;
			}
			else if((Tecla==Play) && (Temp_OV=1)){ //NO
				estado=0;
				}
				else{ 
				     estado= estado;
				     }
		break;


	default: estado=0;


}//del switch(estado)
} // del while


return 0;
} // del main


/*
En_S_Us=;
LEDs_ON=;
Melodia_ON=;
En_Mem=;
Rst_Mem=;
Cancion=;
Estado_LCD=;
AUX_LCD=;
*/

/*
uint32_t a=1;	
uint32_t estado=0;
uint32_t cont=1;

while(1){

if(t()==a){
////inicio
switch(estado)	{
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

a=0;	}


if(t()==0) a=1;

} // Del While

return 0;
}
*/
