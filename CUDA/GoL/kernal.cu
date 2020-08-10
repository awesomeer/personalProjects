#include <stdlib.h>

#include <cuda.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <math.h>


__managed__ int cuWidth, cuHeight;
static bool * cudaPtA;
static bool * cudaPtB;
static unsigned char * renderImage;


__global__
void kernal(bool * current, bool * next){
    int row = threadIdx.y + blockIdx.y * blockDim.y;
    int col = threadIdx.x + blockIdx.x * blockDim.x;

    if(row < 0 || row >= cuHeight)
        return;
    if(col < 0 || col >= cuWidth)
        return;
    


    int neighbors = 0;

    for(int i = -1; i < 2; i++){
        int tempRow = 0;
        if(row+i < 0){
            tempRow = cuHeight-1;
        }
        else if(row+i >= cuHeight){
            tempRow = 0;
        }
        else{
            tempRow = row + i;
        }

        for(int j = -1; j < 2; j++){
            int tempCol = 0;
            if(col+j < 0){
                tempCol = cuWidth-1;
            }
            else if(col+j >= cuWidth){
                tempCol = 0;
            }
            else{
                tempCol = col + j;
            }

            if(!(i == 0 && j == 0)){
                if(current[tempRow* cuWidth + tempCol]){
                    neighbors++;
                }
            }
        }
    }

    int index = row * cuWidth + col;
    bool cell = current[index];

    if(!cell && neighbors == 3){
        next[index] = true;
    }
    else if(cell && (neighbors < 2 || neighbors > 3)){
        next[index] = false;
    }
    else if(cell && (neighbors == 2 || neighbors == 3)){
        next[index] = true;
    }
        
}


__global__
void render(bool* state, unsigned char* image) {

    int row = threadIdx.y + blockIdx.y * blockDim.y;
    int col = threadIdx.x + blockIdx.x * blockDim.x;

    if (row < 0 || row >= cuHeight)
        return;
    if (col < 0 || col >= cuWidth)
        return;


    int step = cuWidth * cuHeight;
    unsigned char* red = image;
    unsigned char* green = &image[step];
    unsigned char* blue = &image[2 * step];

    int index = row * cuWidth + col;

    if (state[index]) {
        red[index] = 256 * row / cuHeight;
        green[index] = 256 * col / cuWidth;
        blue[index] = 255;
    }
    else {
        red[index] = 0;
        green[index] = 0;
        blue[index] = 0;
    }
}



extern void randomize(int size) {
    bool* life = (bool*)malloc(sizeof(bool) * size);
    for (int i = 0; i < size; i++) {
        life[i] = rand() / (RAND_MAX / 2);
    }

    cudaMemcpy(cudaPtA, life, sizeof(bool) * size, cudaMemcpyHostToDevice);

    free(life);
}

extern void initCUDA(int width, int height){
    int size = width * height;
    cuWidth = width;
    cuHeight = height;

    cudaMalloc(&cudaPtA, size * sizeof(bool));
    cudaMalloc(&cudaPtB, size * sizeof(bool));
    cudaMalloc(&renderImage, 3 * size * sizeof(unsigned char));

    randomize(size);
}



extern void iteration(unsigned char * image){
    int size = cuWidth * cuHeight;
    dim3 block(32,32);
    dim3 grid((cuWidth/32)+1, (cuHeight/32)+1);
        
    //Iterate one step in simulation
    kernal<<<grid, block>>>(cudaPtA, cudaPtB);
    cudaMemcpy(cudaPtA, cudaPtB, size * sizeof(bool), cudaMemcpyDeviceToDevice);

    //Render image
    render<<<grid, block>>>(cudaPtB, renderImage);
    cudaMemcpy(image, renderImage, 3 * size * sizeof(unsigned char), cudaMemcpyDeviceToHost);

}

extern void exitCUDA(){
    cudaFree(cudaPtA);
    cudaFree(cudaPtB);
    cudaFree(renderImage);
}