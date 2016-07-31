#include <avr/io.h>
#include <avr/interrupt.h>


volatile uint8_t pin_input;


ISR(PCINT0_vect){
    pin_input = ((PINB >> PB3) & 0x1);
}

