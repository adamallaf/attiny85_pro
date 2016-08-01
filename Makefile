CC = avr-gcc
OBJC = avr-objcopy

SRCDIR = src
OBJDIR = obj
BINDIR = bin

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

OBJS = main.o wdt.o wdt_isr.o timer.o state_machine.o states.o portb_isr.o timer0_isr.o

all:	dirs	$(OBJS)
	$(CC) $(CFLAGS) -o $(OBJDIR)/main.out $(addprefix $(OBJDIR)/,$(OBJS))
	$(OBJC) -j .text -j .data -O ihex $(OBJDIR)/main.out $(BINDIR)/main.hex

%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

dirs:
	@mkdir $(OBJDIR)
	@mkdir $(BINDIR)

install:	all
	avrdude $(PFLAGS) -U flash:w:$(BINDIR)/main.hex:i

clean:
	@rm -rf $(OBJDIR) $(BINDIR)

