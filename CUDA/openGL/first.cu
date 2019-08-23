#include <stdio.h>

#include <cuda.h>
#include <cuda_runtime_api.h>
#include <cuda_runtime.h>




int main(){
	cudaDeviceProp device;
	cudaGetDeviceProperties(&device, 0);
	printf("%s\n", device.name);
	printf("Number of multiprocessors: %d\n", device.multiProcessorCount);
	printf("Global memory: %f GB\n", (double) device.totalGlobalMem/(1024*1024*1024));
	printf("Maximum number threads per block: %d\n", device.maxThreadsPerBlock);
	printf("Maximum number of threads per diminsion x: %d y: %d z: %d\n", device.maxThreadsDim[0], device.maxThreadsDim[1], device.maxThreadsDim[2]);
	printf("Maximum grid size x: %d y: %d z: %d\n", device.maxGridSize[0], device.maxGridSize[1], device.maxGridSize[2]);
	printf("Thread Wrap Size: %d\n", device.warpSize);
}
