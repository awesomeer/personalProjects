#include "kernel.h"
#include <cuda.h>
#include <cuda_runtime.h>
#include <cuda_runtime_api.h>
#include <device_launch_parameters.h>


__managed__ static int width;
__managed__ static int height;


#define SIZE (width*height)

bool* current, *next;
unsigned char* frame;



__global__
void randomize(bool* curr) {
	int index = threadIdx.x + 1024 * blockIdx.x;
	curr[index] = rand() % 2;
}


//Wrapper Function to call the GPU kernel
void randomize(void) {
	randomize << <SIZE/1024, 1024 >> > (current);
}

void initCUDA(int swidth, int sheight, unsigned int seed) {
	width = swidth;
	height = sheight;

	srand(seed);
	cudaMalloc(&current, sizeof(bool) * width * height); //Allocate memory for current world
	cudaMalloc(&next, sizeof(bool) * width * height); //Allocate memory to store next iteration
	cudaMalloc(&frame, sizeof(unsigned char) * width * height); //Memory to store the rendered frame

	randomize();
}

void iterate(unsigned char* world) {

}

void freeCUDA(void);