#include "timer.h"
#include "wdt.h"


static volatile uint16_t seconds, delay_counter;

void timer_init(){
    seconds = 0;
    delay_counter = 0;
    WDT_enable();
}

inline void time_counter(){
    seconds++;
    delay_counter++;
}

uint16_t get_seconds(){
    return seconds;
}

void counter_reset(){
    seconds = 0;
    delay_counter = 0;
}

void s_delay(uint16_t sec){
    delay_counter = 0;
    while(sec > delay_counter);
}
