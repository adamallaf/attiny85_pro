#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/power.h>
#include "timer.h"
#include "wdt.h"
#include "state_machine.h"
#include "states.h"


extern volatile uint8_t pin_input;


int main(){
    cli();                  // disable interrupts
    WDT_disable();          // disable WDT

    clock_prescale_set(clock_div_1);

    state_init(armed);

    timer_init();           // init timer based on WDT

    DDRB = 0x00;
    DDRB |= (1 << PB2);     // PB2 as outputs

    //DDRB &= ~(1 << PB3);    // PB3 as input
    PORTB |= (1 << PB3);    // enable pull-up resistor
    GIMSK |= (1 << PCIE);   // pin change interrupt enable
    PCMSK |= (1 << PCINT3); // select interrupt on PB3 change

    pin_input = 0;

    sei();                  // enable interrupts
    while(1){
        state_exec();
    }
    return 0;
}

