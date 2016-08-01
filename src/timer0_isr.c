#include <avr/interrupt.h>


ISR(TIM0_COMPA_vect){
    static uint8_t counter = 1, updwn = 0;
    if(counter == 0x00)
        updwn = 1;
    if(counter == 0xff)
        updwn = 0;
    if(updwn)
        counter++;
    else
        counter--;
    OCR0A = counter;
}

