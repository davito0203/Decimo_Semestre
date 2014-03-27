#ifndef SPIKEHW_H
#define SPIKEHW_H

#define PROMSTART 0x00000000
#define RAMSTART  0x00000800
#define RAMSIZE   0x400
#define RAMEND    (RAMSTART + RAMSIZE)

#define RAM_START 0x40000000
#define RAM_SIZE  0x04000000

#define FCPU      100000000

#define UART_RXBUFSIZE 32

/****************************************************************************
 * Types
 */
typedef unsigned int  uint32_t;    // 32 Bit
typedef signed   int   int32_t;    // 32 Bit

typedef unsigned char  uint8_t;    // 8 Bit
typedef signed   char   int8_t;    // 8 Bit

/****************************************************************************
 * Interrupt handling
 */
typedef void(*isr_ptr_t)(void);

void     irq_enable();
void     irq_disable();
void     irq_set_mask(uint32_t mask);
uint32_t irq_get_mak();

void     isr_init();
void     isr_register(int irq, isr_ptr_t isr);
void     isr_unregister(int irq);

/****************************************************************************
 * General Stuff
 */
void     halt();
void     jump(uint32_t addr);


/****************************************************************************
 * Timer
 */
#define TIMER_EN     0x08    // Enable Timer
#define TIMER_AR     0x04    // Auto-Reload
#define TIMER_IRQEN  0x02    // IRQ Enable
#define TIMER_TRIG   0x01    // Triggered (reset when writing to TCR)

typedef struct {
	uint32_t ledo;//volatile uint32_t tcr0;
	uint32_t RS;
	uint32_t RW;
	uint32_t E;
	uint32_t Data_out;

	volatile uint32_t compare0;
	volatile uint32_t counter0;
	volatile uint32_t tcr1;
	volatile uint32_t compare1;
	volatile uint32_t counter1;
	// uint32_t ledo;
	
} timer_t;

void msleep(uint32_t msec);
void nsleep(uint32_t nsec);

//void tic_init();

uint32_t t();

void lcd_iniciar(int c_inicio);
void titulo(int paso);
//Agregado David
void espacio1(int esp);
void titulo1(int paso1);

//void tem(int dato,int cont);
//////////////////////////////////LCD
/*typedef struct {
	//volatile uint8_t address;
	volatile uint8_t Data_out;
        volatile uint8_t RS;
        volatile uint8_t E;
	 
				
} lcd_t;

//void LCD_Data (uint8_t addr,uint8_t dato);
//void LCD_Instruction (uint8_t inst);
void lcd_set();
void lcd_instset();
void lcd_control();

//////////////////////////
*///***************************************************************************
 //* GPIO0
 
//typedef struct {
	/*volatile uint32_t ctrl;
	volatile uint32_t dummy1;
	volatile uint32_t dummy2;
	volatile uint32_t dummy3;
	volatile uint32_t in;
	volatile uint32_t out;
	volatile uint32_t oe;*/
	//volatile uint32_t gpio_dir;
//	uint32_t gpio_in;
//////////////Rs, E, Data_out, y rw son para la lcd, no le pongas
///////////// atencion
	
	
        
        

//} gpio_t;
////////funcion traer el dato que entra al gpio
//uint32_t  traer();
//////////

/***************************************************************************
 * UART0
 */
//#define UART_DR   0x01                    // RX Data Ready
//#define UART_ERR  0x02                    // RX Error
//#define UART_BUSY 0x10                    // TX Busy

//typedef struct {
//   volatile uint32_t ucr;
//   volatile uint32_t rxtx;
	
//} uart_t;

//void uart_init();
//void uart_putchar(char c);
//void uart_putstr(char *str);
//char uart_getchar();



/***************************************************************************
 * Pointer to actual components
 */
extern timer_t  *timer0;
//extern uart_t   *uart0; 
//extern gpio_t   *gpio0; 
//extern uint32_t *sram0; 

#endif // SPIKEHW_H
