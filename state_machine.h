#ifndef __STATE_MACHINE_H__
#define __STATE_MACHINE_H__


typedef void *(*StateFunc)();

void state_init(StateFunc );

void state_exec();

#endif

