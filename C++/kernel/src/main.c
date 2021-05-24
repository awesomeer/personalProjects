
#include "../inc/stdio.h"

void main(){

    clearScreen();

    unsigned char byte = 0;
    while(1){
        *((unsigned short *) 0xb8000) = (0x0F << 8) + byte++;
    }

}
