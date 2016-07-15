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

OBJS = main.o wdt.o wdt_isr.o timer.o

all:	$(OBJS)
	$(CC) $(CFLAGS) -o main.out $(OBJS)
	$(OBJC) -j .text -j .data -O ihex main.out main.hex

%.o: %.c
	$(CC) $(CFLAGS) -c $<

install:	all
	avrdude $(PFLAGS) -U flash:w:main.hex:i

clean:
	rm -rvf *.o main.out main.hex

