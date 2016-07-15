#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/power.h>


volatile uint16_t ticks = 0;

int main(){
    clock_prescale_set(clock_div_1);

    TIMSK |= (1 << OCIE0A); // interrupt on compare
    TCCR0B |= (1 << CS00);  // no prescaler T = 1.25e-7 S
    TCNT0 = 0;              // counter = 0
    OCR0A = 0xC8;           // interrupt each 25uS

    DDRB = 0x00;
    DDRB |= (1 << PB2);     // PB2 as outputs

    sei();                  // enable interrupts
    while(1){

    }
    return 0;
}

ISR(TIM0_COMPA_vect){
    ticks++;
    // toggle PB2 each 0.5 second
    if(ticks == 20000){ // 25e-6 * 20000 = 0.5 S
        PORTB ^= (1 << PB2);
        ticks = 0;
    }
}

