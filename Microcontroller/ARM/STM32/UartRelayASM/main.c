#include <stdio.h>
#include <stdlib.h>
#include <stm32l432xx.h>
#include "Fifo.h"


Fifo_t HFifo;
Fifo_t DFifo;

extern char rmain(void);

int main(void){
	NVIC_EnableIRQ(USART1_IRQn);
	NVIC_EnableIRQ(USART2_IRQn);
	return rmain();
}
