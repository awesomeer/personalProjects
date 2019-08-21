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
	int input[20];
	for(int i = 0; i < 20; i++){
		input[i] = i*2;
	}

	int * cudaInput;
	cudaMalloc(&cudaInput, sizeof(int) * 20);
	cudaMemcpy(cudaInput, input, sizeof(int) * 20, cudaMemcpyHostToDevice);
	inc<<<1, 20>>>(cudaInput);
	cudaDeviceSynchronize();
	cudaError_t error = cudaGetLastError();
	printf("%s\n", cudaGetErrorString(error));
	cudaMemcpy(input, cudaInput, sizeof(int) * 20, cudaMemcpyDeviceToHost);
	
	for(int i = 0; i < 20; i++){
		printf("%d: %d\n", i, input[i]);
	}
	
	cudaFree(cudaInput);

}

