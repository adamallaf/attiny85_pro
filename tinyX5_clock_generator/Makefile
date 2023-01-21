CC		=	avr-gcc
MCU		=	attiny85
# MCU		=	attiny25

# f = 8MHz
F_CPU	=	8000000

CFLAGS	=	-DF_CPU=$(F_CPU) -mmcu=$(MCU) -Os

all:	tiny_clock

tiny_clock:
	$(CC) tiny_clock_gen.S $(CFLAGS) -o tiny_clk.out
	avr-objcopy -O ihex tiny_clk.out tiny_clk.hex
	$(eval HEX_FILE := tiny_clk.hex)

install:
	avrdude -P /dev/ttyUSB0 -c avrisp -b 19200 -p $(MCU) -U flash:w:$(HEX_FILE):i -U lfuse:w:0x62:m	-U hfuse:w:0xDF:m

clean:
	@rm -rv *.out tiny_clk.hex
