# 1 "soc-hw.c"
# 1 "<interno>"
# 1 "<línea-de-orden>"
# 1 "soc-hw.c"
# 1 "soc-hw.h" 1
# 19 "soc-hw.h"
typedef unsigned int uint32_t;
typedef signed int int32_t;

typedef unsigned char uint8_t;
typedef signed char int8_t;




typedef void(*isr_ptr_t)(void);

void irq_enable();
void irq_disable();
void irq_set_mask(uint32_t mask);
uint32_t irq_get_mak();

void isr_init();
void isr_register(int irq, isr_ptr_t isr);
void isr_unregister(int irq);




void halt();
void jump(uint32_t addr);
# 54 "soc-hw.h"
typedef struct {
 volatile uint32_t tcr0;
 volatile uint32_t compare0;
 volatile uint32_t counter0;
 volatile uint32_t tcr1;
 volatile uint32_t compare1;
 volatile uint32_t counter1;
} timer_t;

void msleep(uint32_t msec);
void nsleep(uint32_t nsec);

void tic_init();





typedef struct {
 volatile uint32_t ctrl;
 volatile int operation;
 volatile int hours;
 volatile int minutes;
 volatile uint32_t in;
 volatile uint32_t out;
 volatile uint32_t oe;
} gpio_t;
# 89 "soc-hw.h"
typedef struct {
   volatile uint32_t ucr;
   volatile uint32_t rxtx;
} uart_t;

void uart_init();
void uart_putchar(char c);
void uart_putstr(char *str);
char uart_getchar();





extern timer_t *timer0;
extern uart_t *uart0;
extern gpio_t *gpio0;
extern uint32_t *sram0;
# 2 "soc-hw.c" 2

uart_t *uart0 = (uart_t *) 0xF0000000;
timer_t *timer0 = (timer_t *) 0xF0010000;
gpio_t *gpio0 = (gpio_t *) 0xF0020000;


uint32_t msec = 0;




void sleep(int msec)
{
 uint32_t tcr;


 timer0->compare1 = (50000000/1000)*msec;
 timer0->counter1 = 0;
 timer0->tcr1 = 0x08 | 0x02;

 do {

   tcr = timer0->tcr1;
  } while ( ! (tcr & 0x01) );
}

void tic_init()
{

 timer0->compare0 = (50000000/1000);
 timer0->counter0 = 0;
 timer0->tcr0 = 0x08 | 0x04 | 0x02;
}




void uart_init()
{






}

char uart_getchar()
{
 while (! (uart0->ucr & 0x01)) ;
 return uart0->rxtx;
}

void uart_putchar(char c)
{
 while (uart0->ucr & 0x10) ;
 uart0->rxtx = c;
}

void uart_putstr(char *str)
{
 char *c = str;
 while(*c) {
  uart_putchar(*c);
  c++;
 }
}
