#ifndef _FIFO_H_
#define _FIFO_H_

#include <stdint.h>
#define MAXSIZE 1024

typedef struct{
	int32_t data[MAXSIZE];
	uint16_t putIndex;
	uint16_t getIndex;
} FIFO;

void FifoInit(FIFO * in);
uint8_t FifoGet(FIFO * in, uint32_t * get);
uint8_t FifoPut(FIFO * in, uint32_t put);

#endif
