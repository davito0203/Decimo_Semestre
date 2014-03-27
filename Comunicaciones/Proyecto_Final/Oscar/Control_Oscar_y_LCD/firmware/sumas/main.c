#include "soc-hw.h"
 
int main(int argc, char **argv)
{
 
	uint32_t  a, b, c, i;
	uint8_t c_char;
 
	c = 0;	
	i = 0;
 
	uart_putstr("Ingrese el numero uno \r\n");
	a = uart_getint();
	uart_putstr("Ingrese el numero dos \r\n");
	b = uart_getint();
 
	a = a - 48;
	b = b - 48;
 
	while ( i < b )
	{
		c = c + a;
		i = i + 1;
	}
 
	c = c + 48;
	c_char = (char) c;
 
	uart_putstr("El resultado es \r\n");
	uart_putchar(c_char);
 
	return 0;
 
}

