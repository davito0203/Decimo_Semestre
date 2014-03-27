# 1 "main.c"
# 1 "<interno>"
# 1 "<línea-de-orden>"
# 1 "main.c"


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
# 4 "main.c" 2

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


ADC_t *ADC0 = (ADC_t *) 0xF0040000;
visualization_t *display0 = (visualization_t *) 0xF0030000;



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



void update_display_state(int state, int section)
{
 if(display0->data_section[section]<4)
 {
  if(state == 1) {
  display0->data_section[section]=display0->data_section[section]+4; }
 }
 else
 { if(state == 0) {
  display0->data_section[section]=display0->data_section[section]-4; }
 }
}

void update_display_criticall(int state, int section)
{
 if((display0->data_section[section]==0)||(display0->data_section[section]==1)||(display0->data_section[section]==4)||(display0->data_section[section]==5))
 {
  if(state == 1) {
  display0->data_section[section]=display0->data_section[section]+2; }
 }
 else
 { if(state == 0) {
  display0->data_section[section]=display0->data_section[section]-2; }
 }
}

void update_display_criticalh(int state, int section)
{
 if((display0->data_section[section]==0)||(display0->data_section[section]==2)||(display0->data_section[section]==4)||(display0->data_section[section]==6))
 {
  if(state == 1) {
  display0->data_section[section]=display0->data_section[section]+1; }
 }
 else
 { if(state == 0) {
  display0->data_section[section]=display0->data_section[section]-1; }
 }
}


int main(int argc, char **argv)
{


 int levels_ADC[8][3];
 int shedule [6][9];


 int x,y,n,z;
 ADC0->enable_ADC = 1;
 display0->enable = 1;
 gpio0->operation=1;
 y=0;
 for(y=0;y<8;y++)
 {
  display0->data_section[y] =0;
 }



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
# 152 "main.c"
 for(;;)
 {
  for(x=0;x<8;x++)
  {
   if(ADC0->data_ADC[x] >= levels_ADC [x][0]) {
    update_display_criticalh(1, x);
    update_display_criticall(0, x); }
   else {
    if(ADC0->data_ADC[x] <= levels_ADC [x][1]) {
     update_display_criticall(1, x);
     update_display_criticalh(0, x); }
    else {
     update_display_criticall(0, x);
     update_display_criticalh(0, x); } }
   if(display0->switches[x] == 0){
    if(ADC0->data_ADC[x] >= levels_ADC [x][0]) {
     update_display_state(0,x); }
    else {
     update_display_state(1,x); } }
   else {
    for (y=0;y<6;y++){
     if(gpio0->hours == shedule [y][0]) {
      if(shedule [y][x+1]==1) {
       if(ADC0->data_ADC[x] <= levels_ADC [x][2]) {
        update_display_state(1, x);
       }
       else {
        update_display_state(0, x);
       }
      }
      else {
       update_display_state(0, x);
      }
     }
     else {
      if(ADC0->data_ADC[x] <= levels_ADC [x][1]) {
       update_display_state(1, x); }
      else {
       if(ADC0->data_ADC[x] > levels_ADC [x][2]) {
        update_display_state(0, x);
       }
      }
     }
    }
   }
  }

 }
}
