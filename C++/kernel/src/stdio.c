
#include "../inc/stdio.h"


#define COLUMNS 80
#define ROWS 25
#define SIZE (ROWS*COLUMNS)

typedef struct cursor_s
{
    unsigned char x;
    unsigned char y;
} cursor_t;


static cursor_t cursor = {0,0};
static unsigned char color = 0x0F;
static unsigned short pos = 0;

unsigned short * const VIDEOMEM = (unsigned short * const) 0xb8000;

void setCursor(char x, char y){
    cursor.x = x;
    cursor.y = y;

    pos = (y * 80) + x;
}

unsigned char getCursorX(){
    return cursor.x;
}
unsigned char getCursorY(){
    return cursor.y;
}


void setForegroundColor(unsigned char byte){
    color = (color & 0xF0) | (byte & 0x0F);
}
void setBackgroundColor(unsigned char byte){
    color = (color & 0x0F) | ((byte & 0x0F) << 4);
}

void scrollUp(){
    for(int i = 0; i < (ROWS-1)*COLUMNS; i++){
        VIDEOMEM[i] = VIDEOMEM[i + COLUMNS];
    }
}


void putc(unsigned char data){

    

}

void puts(char * str){
    pos = 0;
    color = 0x0F;
    
    if(!str)
        return;

    while(*str){

        VIDEOMEM[pos++] = (color << 8) | *str++;
        pos = pos % SIZE;

        if(pos == 0){
            scrollUp();
            pos = COLUMNS * (ROWS-1);
        }
    }

}

void clearScreen(){
    unsigned short * const video = (unsigned short * const) 0xb8000;
    for(int i = 0; i < 80*25; i++){
        video[i] = 0x0000;
    }
}
