#include <avr/interrupt.h>
#include <avr/io.h>


ISR(WDT_vect){
    PORTB ^= (1 << PB2);
}

