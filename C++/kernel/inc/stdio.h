
#ifndef _STDIO_H_
#define _STDIO_H_

void setCursor(char x, char y);
unsigned char getCursorX();
unsigned char getCursorY();


void setForegroundColor(unsigned char byte);
void setBackgroundColor(unsigned char byte);

void putc(unsigned char data);
void puts(char * str);


void clearScreen();



#endif

