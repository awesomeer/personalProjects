#include <stdlib.h>

#include <cuda.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <math.h>


__managed__ int cuWidth, cuHeight;
static bool * cuCurr;
static bool * cuNext;
static unsigned char * renderImage;

__device__
int wrap(int index, int size);

__device__
int hashSubImage(int row, int col, int xLen, int yLen);


__global__
void kernal(bool * current, bool * next, unsigned char * image){
    int row = threadIdx.y + blockIdx.y * blockDim.y;
    int col = threadIdx.x + blockIdx.x * blockDim.x;

    if(row < 0 || row >= cuHeight)
        return;
    if(col < 0 || col >= cuWidth)
        return;
    


    int neighbors = 0;

    for(int i = -1; i < 2; i++){
        int tempRow = wrap(row + i, cuHeight);

        for(int j = -1; j < 2; j++){
            int tempCol = wrap(col + j, cuWidth);

            if(!(i == 0 && j == 0)){
                if(current[tempRow* cuWidth + tempCol]){
                    neighbors++;
                }
            }
        }
    }

    int index = row * cuWidth + col;
    bool cell = current[index];

    unsigned char* red = image;
    unsigned char* green = &image[cuWidth * cuHeight];
    unsigned char* blue = &image[2 * cuWidth * cuHeight];

    //if(!cell && neighbors == 3){
    //    next[index] = true;
    //}
    //else if(cell && (neighbors < 2 || neighbors > 3)){
    //    next[index] = false;
    //}
    //else if(cell && (neighbors == 2 || neighbors == 3)){
    //    next[index] = true;
    //}

    if ((!cell && neighbors == 3) || (cell && (neighbors == 2 || neighbors == 3))) {
        next[index] = true;
        red[index] = green[index] = blue[index] = 255;
    }
    else if (cell && (neighbors < 2 || neighbors > 3)) {
        next[index] = false;
        red[index] = green[index] = blue[index] = 0;
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

}


__device__
int hashSubImage(unsigned char * image, int row, int col, int xLen, int yLen) {
    int hashSum = 0;

    for (int y = 0; y < yLen; y++) {
        int yHash = 0;
        if (y < ceil(yLen / 2.0))
            yHash = y;
        else
            yHash = yLen - y - 1;

        for (int x = 0; x < xLen; x++) {
            int xHash = 0;
            if (x < ceil(xLen / 2.0))
                xHash = x;
            else
                xHash = xLen - x - 1;

            int hash = yHash > xHash ? xHash : yHash;
        }
    }
}


__device__
int wrap(int index, int size) {

    while (index < 0)
        index += size;

    return index % size;
}


extern void randomize(int size) {
    bool* life = (bool*)malloc(sizeof(bool) * size);
    for (int i = 0; i < size; i++) {
        life[i] = rand() / (RAND_MAX / 2);
    }

    cudaMemcpy(cuCurr, life, sizeof(bool) * size, cudaMemcpyHostToDevice);

    free(life);
}

extern void initCUDA(int width, int height){
    int size = width * height;
    cuWidth = width;
    cuHeight = height;

    cudaMalloc(&cuCurr, size * sizeof(bool));
    cudaMalloc(&cuNext, size * sizeof(bool));
    cudaMalloc(&renderImage, 3 * size * sizeof(unsigned char));

    randomize(size);
}


extern void iteration(unsigned char * image){
    int size = cuWidth * cuHeight;
    dim3 block(32,32);
    dim3 grid((cuWidth/32)+1, (cuHeight/32)+1);
        
    //Iterate one step in simulation
    kernal<<<grid, block>>>(cuCurr, cuNext, renderImage);
    cudaMemcpy(cuCurr, cuNext, size * sizeof(bool), cudaMemcpyDeviceToDevice);

    //Render image
    render<<<grid, block>>>(cuNext, renderImage);
    cudaMemcpy(image, renderImage, 3 * size * sizeof(unsigned char), cudaMemcpyDeviceToHost);

}

extern void exitCUDA(){
    cudaFree(cuCurr);
    cudaFree(cuNext);
    cudaFree(renderImage);
}