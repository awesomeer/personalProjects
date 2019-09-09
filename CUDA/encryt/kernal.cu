#include <cuda_runtime_api.h>
#include <cuda.h>
#include <cuda_runtime.h>
#include <stdio.h>

//const int  KEY[] =  {0x32,0x28,0x99};

__global__
void kernal(unsigned char * dest, unsigned char * src, int size){
    const int  KEY[] =  {0x32,0x28,0x99};
    int index = threadIdx.x + blockDim.x * blockIdx.x;
    if(index >= size)
        return;
    
    dest[index] = src[index] ^ KEY[index%3];


}

extern void XOR(unsigned char * dest, unsigned char * src, int row, int col){
    unsigned char * dev_src;
    unsigned char * dev_dest;
    int size = sizeof(unsigned char) * 3 * row * col;
    cudaMalloc(&dev_src, size);
    cudaMalloc(&dev_dest, size);

    cudaMemcpy(dev_src, src, size, cudaMemcpyHostToDevice);
    printf("nuawdnanowd");
    kernal<<<(size/1024)+1, 1024>>>(dev_dest, dev_src, size);
    cudaMemcpy(dest, dev_dest, size, cudaMemcpyDeviceToHost);

    cudaFree(dev_src);
    cudaFree(dev_dest);

}