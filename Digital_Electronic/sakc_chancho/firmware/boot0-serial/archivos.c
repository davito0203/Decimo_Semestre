#include "soc-hw.h"
//////////////////////////////////////////////////////////////////////////////////
typedef struct {
	volatile int enable_ADC;
	volatile int data_ADC_0;
	volatile int data_ADC_1;
	volatile int data_ADC_2;
	volatile int data_ADC_3;
	volatile int data_ADC_4;
	volatile int data_ADC_5;
	volatile int data_ADC_6;
	volatile int data_ADC_7;
} ADC_t;

typedef struct {
	volatile int enable;
	volatile int data_section_0;
	volatile int data_section_1;
	volatile int data_section_2;
	volatile int data_section_3;
	volatile int data_section_4;
	volatile int data_section_5;
	volatile int data_section_6;
	volatile int data_section_7;
	volatile int switch_s0;
	volatile int switch_s1;
	volatile int switch_s2;
	volatile int switch_s3;
	volatile int switch_s4;
	volatile int switch_s5;
	volatile int switch_s6;
	volatile int switch_s7;
	volatile int indicator;
	volatile int external_switches;
} visualization_t;

//////////////////////////////////////////////////////////////////////////////////

ADC_t   *ADC0  = (ADC_t *)   0xF0040000;
visualization_t   *display0  = (visualization_t *)   0xF0030000;

//////////////////////////////////////////////////////////////////////////////////

int uart_get_putint()
{
	int a,x,num;
	num=0;
	for (x=0;x<3;x++)
	{
		num=num*10;
		a = uart_getchar();
		uart_putchar(a);
		num = num+a-48;
	}
	return num;
}




//////////////////////////////////////////////////////////////////////////////////

void update_display_criticalh(int state, int section)
{
	int data, new_data;
	switch (section)
	{
		case 0: data=display0->data_section_0;
			break;
		case 1: data=display0->data_section_1;
			break;
		case 2: data=display0->data_section_2;
			break;
		case 3: data=display0->data_section_3;
			break;
		case 4: data=display0->data_section_4;
			break;
		case 5: data=display0->data_section_5;
			break;
		case 6: data=display0->data_section_6;
			break;
		case 7: data=display0->data_section_7;
			break;
	
	}
	if((data==0)||(data==2)||(data==4)||(data==6))
	{	
		if(state == 1)
		{				
		new_data=data+1;
		}
		else
		{
		new_data=data;
		}
	}
	else
	{	if(state == 1)
		{
		new_data=data;
		}	
		else
		{
		new_data=data-1;
		}
	}
	switch (section)
	{
		case 0: display0->data_section_0=new_data;
			break;
		case 1: display0->data_section_1=new_data;
			break;
		case 2: display0->data_section_2=new_data;
			break;
		case 3: display0->data_section_3=new_data;
			break;
		case 4: display0->data_section_4=new_data;
			break;
		case 5: display0->data_section_5=new_data;
			break;
		case 6: display0->data_section_6=new_data;
			break;
		case 7: display0->data_section_7=new_data;
			break;
	
	}

}


//////////////////////////////////////////////////////////////////////////////////
int main(int argc, char **argv)
{	
	////  Shedule data

	int levels_ADC[8][3];
	int type [8];

	//// Peripheral initiation	

	uart_init();
	ADC0->enable_ADC = 1;
	display0->enable = 1;



	int a;
	int b;
	char c;
	for(;;)
	{
	b =display0->external_switches; 
	if(display0->external_switches < 2)
	{
		gpio0->operation=1;
	}
	else
	{
		gpio0->operation=0;
		gpio0->hours = display0->external_switches;
		gpio0->minutes = display0->external_switches;
	}
	switch (b)
		{
		case 1:
			display0->indicator = ADC0->data_ADC_0;	
			break;
		case 2:
			display0->indicator = ADC0->data_ADC_1;	
			break;
		case 4:
			display0->indicator = ADC0->data_ADC_2;	
			break;
		case 8:
			display0->indicator = ADC0->data_ADC_3;	
			break;
		case 16:
			display0->indicator = ADC0->data_ADC_4;	
			break;
		case 32:
			display0->indicator = ADC0->data_ADC_5;	
			break;
		case 64:
			display0->indicator = ADC0->data_ADC_6;	
			break;
		case 128:
			display0->indicator = ADC0->data_ADC_7;	
			break;
		default:
			display0->indicator = ADC0->data_ADC_0;	
			break;
		}
	a = display0->switch_s1;	
	switch (a)
		{
		case 1:
			display0->data_section_1 = 7;	
			break;	 
		case 48:
			display0->data_section_1 = 0;	
			break;
		case 49:
			display0->data_section_1 = 1;	
			break;
		case 50:
			display0->data_section_1 = 2;	
			break;
		case 51:
			display0->data_section_1 = 3;	
			break;
		case 52:
			display0->data_section_1 = 4;	
			break;
		case 53:
			display0->data_section_1 = 5;	
			break;
		case 54:
			display0->data_section_1 = 6;	
			break;
		case 55:
			display0->data_section_1 = 7;	
			break;
		default:
			display0->data_section_1 = 0;
			display0->indicator = 0;	
			break;
		}

	}	 		
}
