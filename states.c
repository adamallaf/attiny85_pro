#include "states.h"
#include <avr/io.h>
#include "timer.h"


State idle(){
    return idle;
}

State armed(){
    return before_alarm;
}

State alarm(){
    return cooldown;
}

State before_alarm(){
    return alarm;
}

State cooldown(){
    return armed;
}

State led_toggle(){
    PORTB ^= (1 << PB2);
    s_delay(2);
    return led_toggle;
}

