#include <avr/interrupt.h>
#include <avr/io.h>
#include "timer.h"


ISR(WDT_vect){
    PORTB ^= (1 << PB2);
    time_counter();
}

