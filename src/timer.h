#ifndef __M_TIMER_H__
#define __M_TIMER_H__


#include "wdt.h"


void timer_init();

void time_counter();

uint16_t get_seconds();

void counter_reset();

void s_delay(uint16_t );

#endif

