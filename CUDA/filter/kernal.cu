#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>
#include <cuda_runtime_api.h>


#define R(row, col, width, height) ((row*width)+col)
#define G(row, col, width, height) ((width*height) + ((row*width)+col))
#define B(row, col, width, height) ((2*width*height) + ((row*width)+col))

#define LDTOLERNACE 1

static unsigned char * dev_dest;
static unsigned char * dev_src;


__global__
void lineDetection(unsigned char * dest, unsigned char * src, int row, int col){
    
    int rowThread = threadIdx.y + blockDim.y * blockIdx.y;
    int colThread = threadIdx.x + blockDim.x * blockIdx.x;
    if(rowThread < 0 || rowThread >= row){
        return;
    }
    else if(colThread < 0 || colThread >= col){
        return;
    }

    int cRed = src[R(rowThread, colThread, col, row)];
    int cGreen = src[G(rowThread, colThread, col, row)];
    int cBlue = src[B(rowThread, colThread, col, row)];

    //right scan
    

    if(colThread < col-1){
        int red = src[R(rowThread, colThread+1, col, row)];
        int green = src[G(rowThread, colThread+1, col, row)];
        int blue = src[B(rowThread, colThread+1, col, row)];
        int average = (abs(cRed-red)+abs(cBlue-blue)+abs(cGreen-green))/3;
        if(average <= LDTOLERNACE){
            dest[R(rowThread, colThread, col, row)] = 0;
            dest[G(rowThread, colThread, col, row)] = 0;
            dest[B(rowThread, colThread, col, row)] = 0;
        }
    }

    if(rowThread < row-1){
        int red = src[R(rowThread+1, colThread, col, row)];
        int green = src[G(rowThread+1, colThread, col, row)];
        int blue = src[B(rowThread+1, colThread, col, row)];
        int average = (abs(cRed-red)+abs(cBlue-blue)+abs(cGreen-green))/3;
        if(average <= LDTOLERNACE){
            dest[R(rowThread, colThread, col, row)] = 0;
            dest[G(rowThread, colThread, col, row)] = 0;
            dest[B(rowThread, colThread, col, row)] = 0;
        }
    }

}





extern void cudaLaunch(unsigned char * dest, unsigned char * src, int row, int col, int filter){

    printf("Line Detection");
    cudaMemcpy(dev_src, src, sizeof(unsigned char) * row * col, cudaMemcpyHostToDevice);
    dim3 block(32,32);
    dim3 grid((col/32) + 1, (row/32) + 1);
    switch(filter){
       case 0:{
            lineDetection<<<grid, block>>>(dev_dest, dev_src, row, col);
       } 
    }

    cudaMemcpy(dest, dev_dest, sizeof(unsigned char) * row * col, cudaMemcpyDeviceToHost);

}

extern void initCuda(unsigned long size){
    cudaMalloc(&dev_dest, size);
    cudaMalloc(&dev_src, size);
}

extern void cudaReset(){
    cudaFree(dev_dest);
    cudaFree(dev_src);
}