#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <cuda_runtime.h>

__global__
void inc(int * array){
	int index = threadIdx.x + (blockDim.x * blockIdx.x);
	array[index]++;
}


int main(){

	int * cudaInput;
	cudaMallocManaged(&cudaInput, sizeof(int) * 20);
	for(int i = 0; i < 20; i++){
		cudaInput[i] = i * 2;
	}

	for(int i = 0; i < 20; i++){
		printf("%d: %d\n", i, cudaInput[i]);
	}

	inc<<<1, 20>>>(cudaInput);
	inc<<<1, 20>>>(cudaInput);

	cudaError_t error = cudaGetLastError();
	printf("%s\n", cudaGetErrorString(error));
	
	for(int i = 0; i < 20; i++){
		printf("%d: %d\n", i, cudaInput[i]);
	}
	
	cudaFree(cudaInput);

}

