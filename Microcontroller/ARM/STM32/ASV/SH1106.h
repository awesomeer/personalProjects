#ifndef SH1106_H_
#define SH1106_H_

#include <stdint.h>
#include "I2C1.h"
#include <string.h>

void SH1106Init(void);

void setPage(uint8_t page);

void setColumn(uint8_t col);

void setContrast(uint8_t con);

void writeCommand(uint8_t * data);

void refresh(void);
void clearScreen(void);
void clearBuffer(void);
void drawVLine(int x, int y, int height);

#endif
