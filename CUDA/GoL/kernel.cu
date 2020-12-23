#include "kernel.h"
#include <cuda.h>
#include <cuda_runtime.h>
#include <cuda_runtime_api.h>
#include <device_launch_parameters.h>
#include <stdio.h>
#include <math.h>

__managed__ static int width;
__managed__ static int height;


#define SIZE (width*height)

bool* current, *next;
unsigned char* frame;


void randomize(void) {
	bool* temp = (bool *) malloc(sizeof(bool) * SIZE);
	for (int i = 0; i < SIZE; i++)
		temp[i] = rand() % 2;

	//temp[0] = true;
	//temp[1] = true;
	//temp[width] = true;

	//temp[3 + width * 2] = true;
	//temp[3 + width * 3] = true;
	//temp[2 + width * 3] = true;

	cudaMemcpy(current, temp, SIZE * sizeof(bool), cudaMemcpyHostToDevice);
	free(temp);
}

void initCUDA(int swidth, int sheight) {
	width = swidth;
	height = sheight;

	cudaMalloc(&current, sizeof(bool) * SIZE); //Allocate memory for current world
	cudaMalloc(&next, sizeof(bool) * SIZE); //Allocate memory to store next iteration
	cudaMalloc(&frame, 3 * sizeof(unsigned char) * SIZE); //Memory to store the rendered frame

	randomize();
}

__device__ __forceinline__
int wrap(int val, int limit) {
	if (val < 0)
		return limit - 1;
	return val % limit;
}

__device__ __forceinline__
int index(int x, int y) {
	return wrap(x, width) + width * wrap(y, height);
}

__device__ __forceinline__
int red(int x, int y) {
	return index(x, y);
}

__device__ __forceinline__
int green(int x, int y) {
	return index(x, y) + SIZE;
}

__device__ __forceinline__
int blue(int x, int y) {
	return index(x, y) + 2 * SIZE;
}


__global__
void computeIteration(bool* current, bool*next, unsigned char* frame) {

	int x = threadIdx.x + 32 * blockIdx.x;
	int y = threadIdx.y + 32 * blockIdx.y;

	if (x >= width || y >= height)
		return;

	//Compute the neighbors each cell has
	char neighbors = 0;
	for (int r = -1; r < 2; r++) {
		int tempY = wrap(y + r, height);

		for (int c = -1; c < 2; c++) {
			int tempX = wrap(x + c, width);

			if (current[index(tempX, tempY)] && !(r == 0 && c == 0))
				neighbors++;
		}
	}


	//Check the rules for cell death and birth
	if (current[index(x, y)] && (neighbors == 2 || neighbors == 3)) {
		next[index(x, y)] = true;
		frame[red(x, y)] = 255;
		frame[green(x, y)] = 255;
		frame[blue(x, y)] = 255;
	}
	else if (!current[index(x, y)] && neighbors == 3) {
		next[index(x, y)] = true;
		frame[red(x, y)] = 255;
		frame[green(x, y)] = 255;
		frame[blue(x, y)] = 255;
	}
	else {
		next[index(x, y)] = false;
		frame[red(x, y)] = 0;
		frame[green(x, y)] = 0;
		frame[blue(x, y)] = 0;
	}
}


__device__
void colorBlock(unsigned char* frame, int x, int y) {

	for (int i = 0; i < 2; i++) {
		for (int j = 0; j < 2; j++) {
			frame[red(x + j, y + i)] = 255;
			frame[green(x + j, y + i)] = 0;
			frame[blue(x + j, y + i)] = 0;
		}
	}
}

__device__
void color5x5(unsigned char* frame, int x, int y, unsigned char redC, unsigned char greenC, unsigned char blueC) {

	for (int i = 0; i < 3; i++) {
		for (int j = 0; j < 3; j++) {
			if (frame[red(x + j, y + i)] == 255 && frame[green(x + j, y + i)] == 255 && frame[blue(x + j, y + i)] == 255) {
				frame[red(x + j, y + i)] = redC;
				frame[green(x + j, y + i)] = greenC;
				frame[blue(x + j, y + i)] = blueC;
			}
		}
	}
}

__device__
void color6x6(unsigned char* frame, int x, int y, unsigned char redC, unsigned char greenC, unsigned char blueC) {

	for (int i = 0; i < 4; i++) {
		for (int j = 0; j < 4; j++) {
			if (frame[red(x + j, y + i)] == 255 && frame[green(x + j, y + i)] == 255 && frame[blue(x + j, y + i)] == 255) {
				frame[red(x + j, y + i)] = redC;
				frame[green(x + j, y + i)] = greenC;
				frame[blue(x + j, y + i)] = blueC;
			}
		}
	}
}


__device__
int computeHash(bool* world, int x, int y, int hashWidth, int hashHeight) {
	int acc = 0;

	for (int i = 0; i < hashHeight; i++) {
		int tempI = i;
		if (i > (hashHeight - 1) / 2)
			tempI = hashHeight - i - 1;
		for (int j = 0; j < hashWidth; j++) {
			int tempJ = j;
			if (j > (hashWidth - 1) / 2)
				tempJ = hashWidth - j - 1;

			if (world[index(x + j, y + i)]) {
				int add = tempI > tempJ ? tempJ : tempI;
				if (i == 0 || j == 0 || i == hashHeight - 1 || j == hashWidth - 1)
					return 0;
				acc += add * add * add;
			}
		}
	}
	
	return acc;
}


__global__
void renderFancy(bool* world, unsigned char* frame) {

	int x = threadIdx.x + 32 * blockIdx.x;
	int y = threadIdx.y + 32 * blockIdx.y;

	if (x >= width || y >= height)
		return;


	int hash = 0;
	hash = computeHash(world, x, y, 6, 6);
	switch (hash) {
	case 14: color6x6(frame, x + 1, y + 1, 255, 0, 255); break;//Loaf Red + Blue = Magenta
	case 22:
	case 34:
	case 6: {
		color6x6(frame, x + 1, y + 1, 0, 255, 255); break;//Toad and Beacon Green + Blue = Cyan
	}
	}

	__syncthreads();

	hash = computeHash(world, x, y, 5, 5);
	switch (hash) {
	case 4: color5x5(frame, x + 1, y + 1, 0, 255, 0); break;//Tub Green
	case 5: color5x5(frame, x + 1, y + 1, 255, 255, 0); break; //Boat Red+Green = Yellow
	case 10: color5x5(frame, x + 1, y + 1, 0, 0, 255); break; //Blinker Blue
	}

	__syncthreads();

	hash = computeHash(world, x, y, 4, 4);
	if (hash == 4)
		colorBlock(frame, x + 1, y + 1);

}

void iteration(unsigned char* world) {

	dim3 block = dim3((width / 32) + 1, (height / 32) + 1);
	dim3 thread = dim3(32, 32);

	computeIteration<<<block, thread>>>(current, next, frame);
	renderFancy<<<block, thread>>>(next, frame);
	cudaDeviceSynchronize();

	cudaMemcpy(world, frame, 3 * sizeof(unsigned char) * SIZE, cudaMemcpyDeviceToHost);
	bool* temp = current;
	current = next;
	next = temp;
	
}

void freeCUDA(void) {
	cudaFree(current);
	cudaFree(next);
	cudaFree(frame);
}


