//////////////////////////////////////////////////////////////////////

#include "soc-hw.h"
//////////////////////////////////////////////////////////////////////
typedef struct {
	volatile int enable_ADC;
	volatile int data_ADC [8];
} ADC_t;

typedef struct {
	volatile int enable;
	volatile int data_section [8];
	volatile int switches [8];
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

void update_display_state(int state, int section)
{
	if(display0->data_section[section]<4)
	{	
		if(state == 1)	{				
		display0->data_section[section]=display0->data_section[section]+4;  }
	}
	else
	{	if(state == 0)	{
		display0->data_section[section]=display0->data_section[section]-4;  }	
	}
}

void update_display_criticall(int state, int section)
{
	if((display0->data_section[section]==0)||(display0->data_section[section]==1)||(display0->data_section[section]==4)||(display0->data_section[section]==5))
	{	
		if(state == 1)	{				
		display0->data_section[section]=display0->data_section[section]+2;  }
	}
	else
	{	if(state == 0)	{
		display0->data_section[section]=display0->data_section[section]-2;  }
	}
}

void update_display_criticalh(int state, int section)
{
	if((display0->data_section[section]==0)||(display0->data_section[section]==2)||(display0->data_section[section]==4)||(display0->data_section[section]==6))
	{	
		if(state == 1)	{				
		display0->data_section[section]=display0->data_section[section]+1;  }
	}
	else
	{	if(state == 0)	{
		display0->data_section[section]=display0->data_section[section]-1;  }
	}
}
//////////////////////////////////////////////////////////////////////////////////

int main(int argc, char **argv)
{
	////  Shedule data

	int levels_ADC[8][3];  ///3 sections
	int shedule [6][9];  /// 4 times/day

	//// Peripheral initiation	
	int x,y,n,z;	
	ADC0->enable_ADC = 1;
	display0->enable = 1;
	gpio0->operation=1;
	y=0;
	for(y=0;y<8;y++)
	{
		display0->data_section[y] =0;		
	}

	//// Acquisition critical levels and shedule
	
	uart_putstr("# \r\n");
	uart_putstr("# \r\n");
	uart_putstr("            |  Maximo   |  Minimo   |  Normal   \r\n");
	uart_putstr("-------------------------------------------------\r\n");
	for (x=0; x<8; x++)	
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
	uart_putstr("    Hora   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 \r\n");
	uart_putstr("-------------------------------------------\r\n");
	for (y=0; y<6; y++)	
	{	
		uart_putstr("   ");
		n=uart_get_putint();
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
/*
	for (y=0; y<8; y++) {
		levels_ADC[y][0]=220;  //4V
		levels_ADC[y][1]=50;   //1V
		levels_ADC[y][2]=110; } //1.9V

	for (x=0; x<6; x++) {	
		shedule [x][0]=x+1;			
		for (y=1; y<9; y++) {
			shedule [x][y]=0;  }  }
	shedule [0][0]=0;		
	shedule [0][1]=1;		
*/	
	// program of irrigation control 

	for(;;)
	{
		for(x=0;x<8;x++)
		{
			if(ADC0->data_ADC[x] >= levels_ADC [x][0]) {
				update_display_criticalh(1, x);
				update_display_criticall(0, x);  }
			else {
				if(ADC0->data_ADC[x] <= levels_ADC [x][1]) {
					update_display_criticall(1, x);
					update_display_criticalh(0, x); }
				else {
					update_display_criticall(0, x);
					update_display_criticalh(0, x); } }
			if(display0->switches[x] == 0){
				if(ADC0->data_ADC[x] >= levels_ADC [x][0])  {
					update_display_state(0,x);  }
				else  {
					update_display_state(1,x);  } }
			else  {
				for (y=0;y<6;y++){
					if(gpio0->hours == shedule [y][0])  {
						if(shedule [y][x+1]==1)  {
							if(ADC0->data_ADC[x] <= levels_ADC [x][2])  {
								update_display_state(1, x); 
							} 
							else {
								update_display_state(0, x); 
							} 
						}
						else  {
							update_display_state(0, x); 
						}
					}	
					else  {
						if(ADC0->data_ADC[x] <= levels_ADC [x][1])  {
							update_display_state(1, x);  }
						else  {
							if(ADC0->data_ADC[x] > levels_ADC [x][2])  {
								update_display_state(0, x);
							}
						}
					}
				}
			}
		}

	}	 		
}
