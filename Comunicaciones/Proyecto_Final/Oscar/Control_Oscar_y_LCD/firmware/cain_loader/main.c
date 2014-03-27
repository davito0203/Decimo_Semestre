/**
 * Primitive first stage bootloader 
 *
 *
 */
#include "soc-hw.h"



void hexprint(unsigned int hexval)
{
  unsigned char digit[8];
  int pos;
  uart_putstr("0x");
  for(pos = 0; pos < 8; pos++)
    {
      digit[pos] = (hexval & 0x0F);  /* last hexit */
      hexval = hexval >> 4;
    }
  for(pos = 7; pos > -1; pos--)
    {
      if( digit[pos] < 0x0A)
        uart_putchar(digit[pos] + '0' );
      else
        uart_putchar(digit[pos] + 'A' - 10);
    }
  uart_putchar('.');
}


int main(int argc, char **argv)
{
  int8_t  *p;
  uint8_t  c;
  unsigned int key, len, autoboot = 1, dispmenu = 1;

  // Initialize UART
  uart_init();

  while(1){ /* loop forever until u-boot gets booted or the board is reset */
    if(dispmenu){
     uart_putstr("\n1: Upload program to RAM\r\n");
//      uart_putstr("2: Upload u-boot to Dataflash\r\n");
//      uart_putstr("3: Upload Kernel to Dataflash\r\n");
//      uart_putstr("4: Start u-boot\r\n");
//      uart_putstr("5: Upload Filesystem image\r\n");
//      uart_putstr("6: Memory test\r\n");
      dispmenu = 0;
    }
    key = uart_getchar();
    autoboot = 0;
    if(key == '1'){
      len = rxmodem((unsigned char *)0x800);
      uart_putstr("Received ");
      hexprint(len);
      uart_putstr(" bytes\r\n");
//      jump(0x1000);
      dispmenu = 1;
    }
    else{
      uart_putstr("Invalid input\r\n");
      dispmenu = 1;
    }
  }
}

