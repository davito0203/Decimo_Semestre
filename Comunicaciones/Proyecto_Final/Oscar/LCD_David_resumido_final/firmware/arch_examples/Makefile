LM32_CC=lm32-linux-gcc
LM32_LD=lm32-linux-ld
LM32_OBJCOPY=lm32-linux-objcopy
LM32_OBJDUMP=lm32-linux-objdump

SREC2VRAM ?= ../../tools/srec2vram/srec2vram
VRAMFILE=image.ram

CFLAGS=-MMD -Wall -g -s -fomit-frame-pointer -mbarrel-shift-enabled   -mmultiply-enabled -mdivide-enabled -msign-extend-enabled
LDFLAGS=-nostdlib -nodefaultlibs -Tlinker.ld 
SEGMENTS = -j .text -j .rodata -j .data

all: image.srec $(VRAMFILE) 

crt0ram.o: crt0ram.S
	$(LM32_CC) $(CFLAGS) -c crt0ram.S

main.o: main.c
	$(LM32_CC) $(CFLAGS) -c main.c


image: crt0ram.o main.o 
	$(LM32_LD) $(LDFLAGS) -Map image.map -N -o image crt0ram.o main.o

image.lst: image
	$(LM32_OBJDUMP) -h -S $< > $@

image.bin: image
	$(LM32_OBJCOPY) $(SEGMENTS) -O srec image image.bin
	$(LM32_OBJCOPY) $(SEGMENTS) -O binary image image_bin.bin

image.srec: image image.lst
	$(LM32_OBJCOPY) $(SEGMENTS) -O srec image image.srec

$(VHDLFILE): image.srec
	$(SREC2VHDL) image.srec > $(VHDLFILE)

$(VRAMFILE): image.srec
	$(SREC2VRAM) image.srec 0x00000000 0x1000 > $(VRAMFILE)

clean:
	rm -f image image.lst image.bin image.srec image.map  *.o *.d *.ram

DEPS := $(wildcard *.d)
ifneq ($(DEPS),)
include $(DEPS)
endif

