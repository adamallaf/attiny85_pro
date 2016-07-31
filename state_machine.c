#include "state_machine.h"


StateFunc statePtr;

void state_init(StateFunc callback){
    statePtr = callback;
}

void state_exec(){
    statePtr = (StateFunc)(*statePtr)();
}

void state_update(StateFunc state){
    statePtr = state;
}

