CC		=	avr-gcc
MCU		=	attiny85
# MCU		=	attiny25

# f = 8MHz
F_CPU	=	8000000

CFLAGS	=	-DF_CPU=$(F_CPU) -mmcu=$(MCU) -Os

HEX_FILE	=	main.hex

all:	servo_to_motor
.PHONY: all install clean

servo_to_motor:
	$(CC) main.S $(CFLAGS) -o main.out
	avr-objcopy -O ihex main.out $(HEX_FILE)

install:
	avrdude -P /dev/ttyUSB0 -c avrisp -b 19200 -p $(MCU) -U flash:w:$(HEX_FILE):i -U lfuse:w:0x62:m	-U hfuse:w:0xDF:m

clean:
	@rm -rv *.out $(HEX_FILE)
