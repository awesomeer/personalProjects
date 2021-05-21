
#include "../inc/stdio.h"

void main(){

    clearScreen();
    // unsigned short * const video = (unsigned short * const) 0xb8000;
    // for(int i = 0; i < 80*25; i++){
    //     video[i] = 0x0000;
    // }
    //puts("Dirt Ba");

    unsigned char byte = 0;
    while(1){
        *((unsigned short *) 0xb8000) = (0x0F << 8) + byte++;
    }

}
