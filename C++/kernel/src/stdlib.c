#include "../inc/stdlib.h"


void memcpy(void * dest, void * src, unsigned int size){

    unsigned char * to = (unsigned char *) dest;
    unsigned char * from = (unsigned char *) src;

    for(unsigned int i = 0; i < size; i++){
        *(to++) = *(from++);
    }
}
