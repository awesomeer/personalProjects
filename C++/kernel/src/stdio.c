
#include "../inc/stdio.h"
#include "../inc/stdlib.h"

unsigned char attribute = 0x0F; //White foreground on black background
int cursor = 0;


static void scrollUp(){

}


void puts(char * str){
    
    if(str == NULL)
        return;

    while(*str){

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
