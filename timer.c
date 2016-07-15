#include "timer.h"
#include "wdt.h"


static uint16_t seconds;

void timer_init(){
    seconds = 0;
    WDT_enable();
}

inline void time_counter(){
    seconds++;
}

uint16_t get_seconds(){
    return seconds;
}

void counter_reset(){
    seconds = 0;
}

