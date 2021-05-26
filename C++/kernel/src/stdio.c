
#include "../inc/stdio.h"
#include "../inc/stdlib.h"

unsigned short * const VIDEOMEM = (unsigned short *) 0xb8000;

unsigned char attribute = 0x0F; //White foreground on black background
int cursor = 0;


static void scrollUp(){
    memcpy(VIDEOMEM, &VIDEOMEM[COLUMNS], 2 * (SIZE-COLUMNS));
}


void puts(char * str){

    unsigned char byte = 0;

    VIDEOMEM[byte] = 0x0F00 | (byte++ + 0x30);

    if(str == NULL){
        return;
    }

    VIDEOMEM[byte] = 0x0F00 | (byte++);
    while(*str){
        VIDEOMEM[byte] = 0x0F00 | (byte++);
        if(cursor >= SIZE){
            scrollUp();
            cursor = 0;
        }
        else{
            VIDEOMEM[cursor++] = (attribute << 8) | ((unsigned char) *(str++));
        }

    }

}

/*
    House Keeping functions
*/
void setAttribute(unsigned char byte){
    attribute = byte;
}

void clearScreen(){
    for(int i = 0; i < 80*25; i++){
        VIDEOMEM[i] = 0x0000;
    }
}
