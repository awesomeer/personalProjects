#include "SH1106.h"

const unsigned char init[] = {0x80, 0xAE, 0x80, 0xD5, 0x80, 0x80, 0x80, 0xA8, 0x80, 0x3F, 0x80, 0xD3, 0x80, 0x00, 0x80, 0x40, 0x80, 0x8D, 
															 0x80, 0x14, 0x80, 0x20, 0x80, 0x00, 0x80, 0xA1, 0x80, 0xC8, 0x80, 0xDA, 0x80, 0x12, 0x80, 0x81,
															 0x80, 0xCF, 0x80, 0xD9, 0x80, 0xF1, 0x80, 0xD8, 0x80, 0x40, 0x80, 0xA4, 0x80, 0xA6, 0x80, 0x20, 0x00, 0x80, 0xAF};

uint8_t screenBuffer[8][128];
uint8_t sendBuffer[129];
	
	
void SH1106Init(void){
	I2C1Init();
	sendData((uint8_t *) init, 53);
	clearScreen();
	for(int i = 0; i < 64; i++){
		drawVLine(i*2, 0,i);
	}
	refresh();
}

void setPage(uint8_t page){
	uint8_t send[] = {0x80, 0xB0 | page};
	sendData(send, 2);
}

void setColumn(uint8_t col){
	col += 2;
	uint8_t send[] = {0x80, 0x10 | (col >> 4), 0x80, col & 0x0F};
	sendData(send, 4);
}

void setContrast(uint8_t con){
	uint8_t send[] = {0x80, 0x81, con};
	sendData(send, 3);
}

void drawVLine(int x, int y, int height){
	for(int i = 0; i < height; i++){
		int temp = y+i;
		screenBuffer[temp/8][x] |= 1 << (temp%8);
	}
}

void refresh(void){
	for(int i = 0; i < 8; i++){
		setPage(i);
		setColumn(0);
		memcpy(&sendBuffer[1], screenBuffer[i], 128);
		sendBuffer[0] = 0x40;
		sendData(sendBuffer, 129);
	}
}

void clearScreen(void){
	for(int i = 0; i < 8; i++){
		for(int j = 0; j < 128; j++)
			screenBuffer[i][j] = 0;
		setPage(i);
		setColumn(0);
		memcpy(&sendBuffer[1], screenBuffer[i], 128);
		sendBuffer[0] = 0x40;
		sendData(sendBuffer, 129);
	}
}
