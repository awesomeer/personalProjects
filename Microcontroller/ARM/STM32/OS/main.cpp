#include <stm32l432xx.h>
#include "OS.h"


#include <stdlib.h>
#include <stdio.h>

void task(void){
	volatile int count = 0;
	while(1){
		count++;
	}
}




int main(void){
	
	
	OS::init();
	OS::addThread((const uint8_t *) "task", task, 2);
	OS::launch();
	
	while(1){
	}
	
	return 0;
}
