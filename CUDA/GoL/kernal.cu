#include <stdlib.h>

#include <cuda.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <math.h>

static bool * cudaPtA;
static bool * cudaPtB;
static unsigned char * renderImage;


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

    int row = threadIdx.y + blockIdx.y * blockDim.y;
    int col = threadIdx.x + blockIdx.x * blockDim.x;

    if (row < 0 || row >= height)
        return;
    if (col < 0 || col >= width)
        return;


    int step = width * height;
    unsigned char* red = image;
    unsigned char* green = &image[step];
    unsigned char* blue = &image[2 * step];

    int index = row * width + col;

    if (state[index]){

        /* Weird Circular render
        red[index] = 256 * sin(3.1415 * row / height);//row * 256 / height;
        green[index] = 256 * sin(3.1415 * col / width);//col * 256 / width;
        blue[index] = 256 * sin(3.1415 * (row * width) / (height*width));
        */

         //Straight rectangular render
        red[index] = row * 256 / height;
        green[index] = col * 256 / width;
        blue[index] = 255;
        
    }
    else{
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

extern void initCUDA(int size){

    cudaMalloc(&cudaPtA, size * sizeof(bool));
    cudaMalloc(&cudaPtB, size * sizeof(bool));
    cudaMalloc(&renderImage, 3 * size * sizeof(unsigned char));

    randomize(size);
}



extern void iteration(unsigned char * image, int width, int height){
    int size = width*height;
    dim3 block(32,32);
    dim3 grid((width/32)+1, (height/32)+1);
        
    //Iterate one step in simulation
    kernal<<<grid, block>>>(cudaPtA, cudaPtB, width, height);
    cudaMemcpy(cudaPtA, cudaPtB, size * sizeof(bool), cudaMemcpyDeviceToDevice);

    //Render image
    render<<<grid, block>>>(cudaPtB, renderImage, width, height);
    cudaMemcpy(image, renderImage, 3 * size * sizeof(unsigned char), cudaMemcpyDeviceToHost);

}

extern void exitCUDA(){
    cudaFree(cudaPtA);
    cudaFree(cudaPtB);
    cudaFree(renderImage);
}