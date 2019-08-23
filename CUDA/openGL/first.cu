#include <stdio.h>

#include <cuda.h>
#include <cuda_runtime_api.h>
#include <cuda_runtime.h>




int main(){
	cudaDeviceProp device;
	cudaGetDeviceProperties(&device, 0);
	printf("%s\n", device.name);
	printf("Global memory: %f\n", (double) device.clockRate/1000);
	printf("Struct address: %p\n", &device);

	char input = 0;
	scanf("%c", &input);
	printf("0x%X\n", input);
}
