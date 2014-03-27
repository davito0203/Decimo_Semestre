//////////////////////////////////////////////////////////////////////

#include "soc-hw.h"
//////////////////////////////////////////////////////////////////////
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
//////////////////////////////////////////////////////////////////////////////

ADC_t   *ADC0  = (ADC_t *)   0xF0040000;
visualization_t   *display0  = (visualization_t *)   0xF0030000;

//////////////////////////////////////////////////////////////////////////////

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

//////////////////////////////////////////////////////////////////////////////

void update_display_state(int state, int data_section)
{
	if(data_section<4)
	{	
		if(state == 1)
		{				
		display0->data_section_0=display0->data_section_0+4;
		}
	}
	else
	{	if(state == 0)
		{
		display0->data_section_0=display0->data_section_0-4;
		}	
	}
}

void update_display_criticall(int state, int section)
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
	if((data==0)||(data==1)||(data==4)||(data==5))
	{	
		if(state == 1)
		{				
		new_data=data+2;
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
		new_data=data-2;
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

	int levels_ADC[3][3];  ///3 sections
	int shedule [4][9];  /// 4 times/day

	//// Peripheral initiation	

	uart_init();
	ADC0->enable_ADC = 1;
	display0->enable = 1;

	//// Acquisition critical levels and shedule
/*
	int x;
		uart_putstr("# \r\n");
		uart_putstr("# \r\n");
		uart_putstr("            |  Maximo   |  Minimo   |  Normal   \r\n");
		uart_putstr("-------------------------------------------------\r\n");
	for (x=0; x<3; x++)	
	{	
		uart_putstr("  Sensor ");
		uart_putchar(x+48);
		uart_putstr("  |    ");
		levels_ADC[x][0]=uart_get_putint();
		uart_putstr("    |    ");
		levels_ADC[x][1]=uart_get_putint();
		uart_putstr("    |    ");
		levels_ADC[x][2]=uart_get_putint();
		uart_putstr("    ");
		uart_putstr("\r\n");
	}
	uart_putstr(" \r\n");
	uart_putstr(" \r\n");
			
	int y,n,z;
		uart_putstr("    Hora   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 \r\n");
		uart_putstr("-------------------------------------------\r\n");
	for (y=0; y<4; y++)	
	{	
		uart_putstr("     ");
		n=uart_getchar();
		uart_putchar(n);
		shedule [x][0]=n-48;;
		uart_putstr("     ");
		for(z=1;z<9;z++)
		{
			uart_putstr("| ");
			n=uart_getchar();
			uart_putchar(n);
			shedule [x][y]=n-48;;
			uart_putstr(" ");
		}
	uart_putstr(" \r\n");
	}
*/
	// program of irrigation control 
	int a;
	int b;
	char c;

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

/*		if (display0->switch_s0!=1)
		{
			display0->data_section_0=7;
		}
		else
		{
			display0->data_section_0=0;
		}

		if (display0->switch_s1!=1)
		{
			display0->data_section_1=7;
		}
		else
		{
			display0->data_section_1=0;
		}

		if (display0->switch_s2!=1)
		{
			display0->data_section_2=7;
		}
		else
		{
			display0->data_section_2=0;
		}

		if (display0->switch_s3!=1)
		{
			display0->data_section_3=7;
		}
		else
		{
			display0->data_section_3=0;
		}
		if (display0->switch_s4!=1)
		{
			display0->data_section_4=7;
		}
		else
		{
			display0->data_section_4=0;
		}
		if (display0->switch_s5!=1)
		{
			display0->data_section_5=7;
		}
		else
		{
			display0->data_section_5=0;
		}
		if (display0->switch_s6!=1)
		{
			display0->data_section_6=7;
		}
		else
		{
			display0->data_section_6=0;
		}
		if (display0->switch_s7!=1)
		{
			display0->data_section_7=7;
		}
		else
		{
			display0->data_section_7=0;
		}*/

	for(;;)
	{
		display0->data_section_0=7;
		display0->data_section_1=7;
		update_display_criticall(0, 0);
		update_display_criticall(0, 1);
		update_display_state(0, &display0->data_section_1);
		update_display_state(0, &display0->data_section_2);
		update_display_state(0, &display0->data_section_3);
		update_display_state(0, &display0->data_section_4);
		update_display_state(0, &display0->data_section_5);
		update_display_state(0, &display0->data_section_6);
		update_display_state(0, &display0->data_section_7);

	}	 		
}
