#include "states.h"
#include <avr/io.h>
#include "timer.h"


extern volatile uint8_t pin_input;


State idle(){
    return idle;
}

State armed(){
    if(pin_input)
        return before_alarm;
    return armed;
}

State alarm(){
    PORTB |= (1 << PB2);
    return cooldown;
}

State before_alarm(){
    static uint8_t n = 0;
    s_delay(1);
    n++;
    if(n > 10){
        n = 0;
        return alarm;
    }
    else
        return before_alarm;
}

State cooldown(){
    s_delay(60);
    PORTB &= ~(1 << PB2);
    return armed;
}

State led_toggle(){
    static uint8_t n = 5;
    PORTB ^= (1 << PB2);
    n = 6 - n;
    s_delay(n);
    return led_toggle;
}

