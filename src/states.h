#ifndef __M_STATES_H__
#define __M_STATES_H__


typedef void *State;

State idle();

State armed();

State alarm();

State before_alarm();

State cooldown();

State led_toggle();

#endif

