
#include "../inc/stdio.h"

void main(){

    clearScreen();

    //setAttribute(0x0F);
    puts("Print String working\n");
    unsigned char byte = 0;
    while(1){
        *((unsigned short *) 0xb8000) = (0x0F << 8) + byte++;
    }

}
