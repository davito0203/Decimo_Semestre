#include "soc-hw.h"


//uart_t   *uart0  = (uart_t *)   0x20000000;
timer_t  *timer0 = (timer_t *)  0x40000000;
//gpio_t   *gpio0  = (gpio_t *)   0x60000000;
// uint32_t *sram0  = (uint32_t *) 0x40000000;
//lcd_t   *lcd0  = (lcd_t *)   0x80000000;

uint32_t msec = 0;

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
