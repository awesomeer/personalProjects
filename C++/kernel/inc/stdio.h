
#ifndef _STDIO_H_
#define _STDIO_H_

#define COLUMNS 80
#define ROWS 25
#define SIZE (ROWS*COLUMNS)

#define VIDEOMEM ((unsigned short * const) 0xb8000)



void puts(char * str);



/*
    House Keeping functions
*/
void setAttribute(unsigned char byte);
void clearScreen();



#endif

