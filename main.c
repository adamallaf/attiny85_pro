#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/power.h>
#include "timer.h"
#include "wdt.h"


int main(){
    cli();                  // disable interrupts
    WDT_disable();          // disable WDT

    clock_prescale_set(clock_div_1);

    timer_init();           // init timer based on WDT

    DDRB = 0x00;
    DDRB |= (1 << PB2);     // PB2 as outputs

    sei();                  // enable interrupts
    while(1){

    }
    return 0;
}

