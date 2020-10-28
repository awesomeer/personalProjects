
#ifndef FIFO_H
#define FIFO_H

#define MAXSIZE 1024

typedef struct Fifo{
	
	unsigned short get;
	unsigned short put;
	unsigned char data[MAXSIZE];
	
} Fifo_t;



extern void fifoInit(void);
extern unsigned char fifoGet(Fifo_t * fifo, unsigned char * get);
extern unsigned char fifoPut(Fifo_t * fifo, unsigned char put);


#endif
