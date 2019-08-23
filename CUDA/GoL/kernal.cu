#include <stdio.h>
#include <time.h>

#include <cuda.h>
#include <cuda_runtime_api.h>
#include <cuda_runtime.h>

//static unsigned char turn;
static unsigned char * cudaPtA;
static unsigned char * cudaPtB;


__global__
void kernal(unsigned char * current, unsigned char * next, int width, int height){
    int row = threadIdx.y + blockIdx.y * blockDim.y;
    int col = threadIdx.x + blockIdx.x * blockDim.x;

    if(row < 0 || row >= height)
        return;
    if(col < 0 || col >= width)
        return;
    


    int neighbors = 0;

    for(int i = -1; i < 2; i++){
        int tempRow = 0;
        if(row+i < 0){
            tempRow = height-1;
        }
        else if(row+i >= height){
            tempRow = 0;
        }
        else{
            tempRow = row + i;
        }

        for(int j = -1; j < 2; j++){
            int tempCol = 0;
            if(col+i < 0){
                tempCol = width-1;
            }
            else if(col+i >= width){
                tempCol = 0;
            }
            else{
                tempCol = col + j;
            }

            if(!(i == 0 && j == 0)){
                if(current[tempRow*width + tempCol] == 255){
                    neighbors++;
                }
            }
        }
    }

    int cell = current[row*width+col];

    if(cell == 0 && neighbors == 3){
        next[row*width+col] = 255;
    }
    else if(cell == 255 && (neighbors < 2 || neighbors > 3)){
        next[row*width+col] = 0;
    }
    else if(cell == 255 && (neighbors == 2 || neighbors == 3)){
        next[row*width+col] = 255;
    }       
}

extern void initCUDA(int size, unsigned char * data){
    //turn = 0;
    cudaMalloc(&cudaPtA, size * sizeof(unsigned char));
    cudaMalloc(&cudaPtB, size * sizeof(unsigned char));
    cudaMemcpy(cudaPtA, data, size * sizeof(unsigned char), cudaMemcpyHostToDevice);
}

extern void iteration(unsigned char * data, int width, int height){
    int size = width*height;
    dim3 block(32,32);
    dim3 grid((width/32)+1, (height/32)+1);

    cudaMemcpy(cudaPtA, data, size * sizeof(unsigned char), cudaMemcpyHostToDevice);
    kernal<<<grid, block>>>(cudaPtA, cudaPtB, width, height);
    cudaMemcpy(data, cudaPtB, size * sizeof(unsigned char), cudaMemcpyDeviceToHost);
}

extern void exitCUDA(){
    cudaFree(cudaPtA);
    cudaFree(cudaPtB);
}