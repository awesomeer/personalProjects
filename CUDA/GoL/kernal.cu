#include <stdio.h>
#include <time.h>

#include <cuda.h>
#include <cuda_runtime_api.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>

bool * cudaPtA;
bool * cudaPtB;


__global__
void kernal(bool * current, bool * next, int width, int height){
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
                if(current[tempRow*width + tempCol]){
                    neighbors++;
                }
            }
        }
    }

    bool cell = current[row*width+col];

    if(!cell && neighbors == 3){
        next[row*width+col] = true;
    }
    else if(cell && (neighbors < 2 || neighbors > 3)){
        next[row*width+col] = false;
    }
    else if(cell && (neighbors == 2 || neighbors == 3)){
        next[row*width+col] = true;
    }       
}

extern void initCUDA(int size, bool * data){
    cudaMalloc(&cudaPtA, size * sizeof(bool));
    cudaMalloc(&cudaPtB, size * sizeof(bool));
}

extern void iteration(bool * data, int width, int height){
    int size = width*height;
    dim3 block(32,32);
    dim3 grid((width/32)+1, (height/32)+1);

    cudaMemcpy(cudaPtA, data, size * sizeof(bool), cudaMemcpyHostToDevice);
    kernal<<<grid, block>>>(cudaPtA, cudaPtB, width, height);
    cudaMemcpy(data, cudaPtB, size * sizeof(bool), cudaMemcpyDeviceToHost);
}

extern void exitCUDA(){
    cudaFree(cudaPtA);
    cudaFree(cudaPtB);
}