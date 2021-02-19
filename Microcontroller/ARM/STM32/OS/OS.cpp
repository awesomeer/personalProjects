#include "OS.h"


void OS::init(){
	OS::runPt = 0;
	OS::ready = nullptr;
	OS::sleeping = nullptr;
	OS::blocked = nullptr;
	
	OS::runPt = OS::sleeping;
}

int8_t OS::addThread(const uint8_t * id, void (*func)(void), uint8_t priority){
	
	
	return 0;
}

void OS::sleep(uint32_t ms){
}

void OS::kill(){
}

void OS::launch(){
}

OS::Semaphore::Semaphore(){
	this->value = 0;
}

OS::Semaphore::Semaphore(int32_t val){
	this->value = val;
}

OS::Semaphore::Semaphore(bool val){
	this->value = val ? 1 : 0;
}

int8_t OS::Semaphore::acquire(){
	
	return 0;
}

int8_t OS::Semaphore::release(){
	
	return 0;
}
