CC = avr-gcc
OBJC = avr-objcopy

MCU = attiny85
# f = 1MHz
F_CPU = 1000000

# compiler flags
CFLAGS = -Wall -Os -mmcu=$(MCU) -DF_CPU=$(F_CPU)

PORT = /dev/ttyACM0
PROGRAMMER = avrisp
BAUDRATE = 19200

# avrdude flags
PFLAGS = -P $(PORT) -c $(PROGRAMMER) -b $(BAUDRATE) -p $(MCU)

.PHONY:	all	install	clean
all:
	$(CC) $(CFLAGS) -o main.o main.c
	$(OBJC) -j .text -j .data -O ihex main.o main.hex

install:
	avrdude $(PFLAGS) -U flash:w:main.hex:i

clean:
	rm -rvf main.o main.hex
