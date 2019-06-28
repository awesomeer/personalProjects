#include "FIFO.h"

void FifoInit(FIFO * in){
	in->getIndex = 0;
	in->putIndex = 0;
}

uint8_t FifoGet(FIFO * in, uint32_t * get){
	if(in->getIndex == in->putIndex)
		return 1;
	
	*get = in->data[in->getIndex];
	in->getIndex = (in->getIndex + 1) % MAXSIZE;
	return 0;
}

uint8_t FifoPut(FIFO * in, uint32_t put){
	if(((in->putIndex + 1) % MAXSIZE) == in->getIndex)
		return 1;
	
	in->data[in->putIndex] = put;
	in->putIndex = (in->putIndex + 1) % MAXSIZE;
	return 0;
}
