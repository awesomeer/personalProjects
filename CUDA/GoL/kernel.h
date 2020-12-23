#pragma once


//CUDA Function Definitions

void initCUDA(int width, int height);

void randomize(void);

void iteration(unsigned char* world);

void freeCUDA(void);