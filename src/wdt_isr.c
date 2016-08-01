#include <avr/interrupt.h>
#include "timer.h"


ISR(WDT_vect){
    time_counter();
}

