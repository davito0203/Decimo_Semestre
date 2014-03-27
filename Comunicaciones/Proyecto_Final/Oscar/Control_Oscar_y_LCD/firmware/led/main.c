//CONTROL CENTRAL
 
#include "soc-hw.h"

int main ()
{
//entradas

volatile uint32_t Tecla=31;//timer0->Tecla;
volatile uint32_t Fin_Cancion=0;//timer0->Fin_Cancion;
//Tecla=timer0->Tecla;
//Fin_Cancion= timer0->Fin_Cancion;
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

// tecla reg temp
while (1){

//Definicion de estados
switch (estado){
Tecla=perifericos0->Tecla;
//if(perifericos0->Tecla==31){      // esto podria funcionar para 	
//Tecla=perifericos0->Tecla;	//arreglar los contadores de nivel 
			//y cancion
//} //else {
//	Tecla==Tecla
//	}

case 0: perifericos0->En_S_Us=0; 	//estado bienvenidos Key PI
	perifericos0->LEDs_ON=0;
	perifericos0->Melodia_ON=0;
	perifericos0->En_Mem=0;
	perifericos0->Rst_Mem=1;
	perifericos0->Cancion=0;
	perifericos0->Estado_LCD=0;
	perifericos0->AUX_LCD=0;
	break;

case 9: perifericos0->En_S_Us=0; 	//estado bienvenidos Key PI // ESTADO INTERMEDIO
	perifericos0->LEDs_ON=0;
	perifericos0->Melodia_ON=0;
	perifericos0->En_Mem=0;
	perifericos0->Rst_Mem=1;
	perifericos0->Cancion=0;
	perifericos0->Estado_LCD=0;
	perifericos0->AUX_LCD=0;
	break;

case 1: perifericos0->En_S_Us=1;	//estado elija cancion
	perifericos0->LEDs_ON=1;
	perifericos0->Melodia_ON=0;
	perifericos0->En_Mem=0;
	perifericos0->Rst_Mem=1;
	perifericos0->Cancion= Cancion_Select(Tecla) ;
	perifericos0->Estado_LCD=1;
	perifericos0->AUX_LCD=Cancion_Select(Tecla) ;
	break;

case 7: perifericos0->En_S_Us=1;	//estado elija cancion // ESTADO INTERMEDIO
	perifericos0->LEDs_ON=1;
	perifericos0->Melodia_ON=0;
	perifericos0->En_Mem=0;
	perifericos0->Rst_Mem=1;
	perifericos0->Cancion= Cancion_Select(Tecla) ;
	perifericos0->Estado_LCD=1;
	perifericos0->AUX_LCD=Cancion_Select(Tecla) ;
	break;

case 2: perifericos0->En_S_Us=0;	//estado elija Nivel
	perifericos0->LEDs_ON=0;
	perifericos0->Melodia_ON=0;
	perifericos0->En_Mem=0;
	perifericos0->Rst_Mem=1;
	perifericos0->Cancion=Cancion;
	perifericos0->Estado_LCD=2;
	perifericos0->AUX_LCD= Nivel_Select(Tecla);

	Temp_Nivel= Nivel_Select(Tecla);
	break;
case 8: perifericos0->En_S_Us=0;	//estado elija Nivel // ESTADO INTERMEDIO
	perifericos0->LEDs_ON=0;
	perifericos0->Melodia_ON=0;
	perifericos0->En_Mem=0;
	perifericos0->Rst_Mem=1;
	perifericos0->Cancion=Cancion;
	perifericos0->Estado_LCD=2;
	perifericos0->AUX_LCD= Nivel_Select(Tecla);

	Temp_Nivel= Nivel_Select(Tecla);
	break;

case 3: perifericos0->En_S_Us=0;	// estado Escucha
	perifericos0->LEDs_ON= Led_Select(Temp_Nivel);
	perifericos0->Melodia_ON=1;
	perifericos0->En_Mem=1;
	perifericos0->Rst_Mem=0;
	perifericos0->Cancion=Cancion;
	perifericos0->Estado_LCD=3;
	perifericos0->AUX_LCD=AUX_LCD;
	break;

case 4: perifericos0->En_S_Us=0;	// estado Preparado
	perifericos0->LEDs_ON=0;
	perifericos0->Melodia_ON=0;
	perifericos0->En_Mem=0;
	perifericos0->Rst_Mem=1;
	perifericos0->Cancion=Cancion;
	perifericos0->Estado_LCD=4;
	perifericos0->AUX_LCD=AUX_LCD;
	break;

case 5: perifericos0->En_S_Us=1;	// estado: adelante!!!
	perifericos0->LEDs_ON=Led_Select(Temp_Nivel);
	perifericos0->Melodia_ON=0;
	perifericos0->En_Mem=1;
	perifericos0->Rst_Mem=0;
	perifericos0->Cancion=Cancion;
	perifericos0->Estado_LCD=5;
	perifericos0->AUX_LCD=AUX_LCD;
	break;

case 6: perifericos0->En_S_Us=0;	// estado: ¿otra vez?
	perifericos0->LEDs_ON=0;
	perifericos0->Melodia_ON=0;
	perifericos0->En_Mem=0;
	perifericos0->Rst_Mem=1;
	perifericos0->Cancion=Cancion;
	perifericos0->Estado_LCD=6;
	perifericos0->AUX_LCD=Select_OV(Tecla);

	Temp_OV= Select_OV(Tecla);
	break;

default:perifericos0->En_S_Us=0; 	//Por default: estado bienvenidos Key PI
	perifericos0->LEDs_ON=0;
	perifericos0->Melodia_ON=0;
	perifericos0->En_Mem=0;
	perifericos0->Rst_Mem=1;
	perifericos0->Cancion=0;
	perifericos0->Estado_LCD=0;
	perifericos0->AUX_LCD=0;

}


//definicion de transicion entre estados REVISAR ESTADO y NESTADO
switch (estado){

	case 0:  if (perifericos0->Tecla==31){estado=9;
		  }else {
			estado=estado;
			}
		break;

	case 9:	if (perifericos0->Tecla==Play) {  // ESTADO INTERMEDIO
			estado=1;
			}else {
			       estado=estado;
			       }
			 //msleep(50000);
			 //estado=1;
		break;

	case 1:  if (perifericos0->Tecla==31){estado=7;
		  }else {
			estado=estado;
			}
		break;

	case 7:	if (perifericos0->Tecla==Play) {	// ESTADO INTERMEDIO
			estado=2;
			}
			else if(Tecla==Stop){
				estado=0;
				}
				else{ 
				     estado= estado;
				     }
		 break;


	case 2:	if (perifericos0->Tecla==31){estado=8;
		  }else {
			estado=estado;
			}
		break;

	case 8: if (perifericos0->Tecla==Play) {	// ESTADO INTERMEDIO
			estado=3;
			}
			else if(perifericos0->Tecla==Stop){
				estado=1;
				}
				else{ 
				     estado= estado;
				     }
		break;


	case 3:	if (perifericos0->Fin_Cancion==1) {
			estado=4;
			}
			else if(perifericos0->Tecla==Stop){
				estado=2;
				}
				else{ 
				     estado= estado;
				     }
		break;


	case 4: if (perifericos0->Tecla==Stop) { //ojo actualizar tecla!!!
			estado=2;
			}
			else {
			     //msleep(3000); 
			     estado= 5;
			     }
		break;


	case 5:	if (perifericos0->Tecla==Stop) {
			estado=2;
			}
			else if(perifericos0->Fin_Cancion==1){
				estado=6;
				}
				else{ 
				     estado= estado;
				     }
		break;


	case 6:	if ((perifericos0->Tecla==Play) && (Temp_OV=0)){ //TempOV=0 es SI
			estado=3;
			}
			else if((perifericos0->Tecla==Play) && (Temp_OV=1)){ //NO
				estado=0;
				}
				else{ 
				     estado= estado;
				     }
		break;


	default: estado=0;


}//del switch(estado)




Vis_LCD ( Estado_LCD, AUX_LCD);

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

