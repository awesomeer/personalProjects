#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <cuda_runtime.h>

#define SIZE 10

__global__
void inc(int * array){
	int index = threadIdx.x + (blockDim.x * blockIdx.x);
	array[index]++;
}


int main(){

	int input[SIZE];
	for(int i = 0; i < SIZE; i++)
		input[i] = i * 3;
	
	int * cudaInput;
	cudaMalloc(&cudaInput, SIZE * sizeof(int));
	cudaMemcpy(cudaInput, input, SIZE * sizeof(int), cudaMemcpyHostToDevice);

	inc<<<1, 10>>>(cudaInput);

	cudaError_t err = cudaGetLastError();
	printf("%s\n", cudaGetErrorString(err));
	cudaMemcpy(input, cudaInput, SIZE * sizeof(int), cudaMemcpyDeviceToHost);
	for(int i = 0 ; i < SIZE; i++){
		printf("%d: %d\n", i, input[i]);
	}

}

