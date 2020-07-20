#include <stdlib.h>

#include <cuda.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>

static bool * cudaPtA;
static bool * cudaPtB;
static unsigned char * renderImage;

static bool * life;


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


__global__
void render(bool* state, unsigned char* image, int width, int height) {
    //int row = threadIdx.y + blockIdx.y * blockDim.y;
    //int col = threadIdx.x + blockIdx.x * blockDim.x;

    int step = width * height;
    //int index = row * width + col;

    int index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= width * height)
        return;

    if (state[index]){
        image[index] = 255;
        image[index + step] = 255;
        image[index + (2 * step)] = 255;
    }
    else{
        image[index] = 0;
        image[index + step] = 0;
        image[index + (2 * step)] = 0;
    }
}


extern void randomize(int size) {
    for (int i = 0; i < size; i++) {
        life[i] = rand() > (RAND_MAX / 2);
    }
}

extern void initCUDA(int size){

    life = (bool *) malloc(sizeof(bool) * size);
    randomize(size);

    cudaMalloc(&cudaPtA, size * sizeof(bool));
    cudaMalloc(&cudaPtB, size * sizeof(bool));
    cudaMalloc(&renderImage, 3 * size * sizeof(unsigned char));
}



extern void iteration(unsigned char * image, int width, int height){
    int size = width*height;
    dim3 block(32,32);
    dim3 grid((width/32)+1, (height/32)+1);
        
    //Iterate one step in simulation
    cudaMemcpy(cudaPtA, life, size * sizeof(bool), cudaMemcpyHostToDevice);
    kernal<<<grid, block>>>(cudaPtA, cudaPtB, width, height);
    cudaMemcpy(life, cudaPtB, size * sizeof(bool), cudaMemcpyDeviceToHost);

    //Render image
    render<<<(width*height/1024)+1, 1024>>>(cudaPtB, renderImage, width, height);
    cudaMemcpy(image, renderImage, 3 * size * sizeof(unsigned char), cudaMemcpyDeviceToHost);
}

extern void exitCUDA(){
    free(life);
    cudaFree(cudaPtA);
    cudaFree(cudaPtB);
    cudaFree(renderImage);
}