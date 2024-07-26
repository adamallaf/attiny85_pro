#include <avr/interrupt.h>
#include <avr/io.h>
#include <avr/power.h>
#include <avr/wdt.h>

int main() {
	cli(); // disable interrupts
	// WDT disable
	MCUSR &= ~(1 << WDRF);
	WDTCR |= ((1 << WDCE) | (1 << WDE)); // change enable
	WDTCR = 0x00;

	clock_prescale_set(clock_div_1);

	// WDT enable
	WDTCR |= ((1 << WDCE) | (1 << WDE));             // change enable
	WDTCR = (1 << WDIE) | (1 << WDP1) | (1 << WDP2); // int enabled & 1s timeout

	DDRB = 0x00;
	DDRB |= (1 << PB2); // PB2 as outputs

	sei(); // enable interrupts
	while ( 1 ) {
	}
	return 0;
}

ISR(WDT_vect) { PORTB ^= (1 << PB2); }
