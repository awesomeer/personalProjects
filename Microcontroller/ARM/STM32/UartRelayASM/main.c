#include <stdio.h>
#include <stdlib.h>
#include <stm32l432xx.h>
#include "Fifo.h"


Fifo_t HFifo;
Fifo_t DFifo;

extern void rmain(void);

int main(void){
	
	rmain();
	
	while(1){
		__NOP();
	}
}
