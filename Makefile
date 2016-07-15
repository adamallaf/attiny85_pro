CC = avr-gcc
OBJC = avr-objcopy

MCU = attiny85
# f = 8MHz
F_CPU = 8000000

# compiler flags
CFLAGS = -Wall -Os -mmcu=$(MCU) -DF_CPU=$(F_CPU)

PORT = /dev/ttyACM0
PROGRAMMER = avrisp
BAUDRATE = 19200

# avrdude flags
PFLAGS = -P $(PORT) -c $(PROGRAMMER) -b $(BAUDRATE) -p $(MCU)

all:
	$(CC) $(CFLAGS) -o main.o main.c
	$(OBJC) -j .text -j .data -O ihex main.o main.hex
	avrdude $(PFLAGS) -U flash:w:main.hex:i

clean:
	rm -rvf main.o main.hex

