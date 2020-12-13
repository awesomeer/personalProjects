#pragma once


//CUDA Function Definitions

void initCUDA(int width, int height);

void randomize(void);

void iterate(unsigned char* world);

void freeCUDA(void);