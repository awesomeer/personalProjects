#include "..\inc\kernel.h"
#include <cuda.h>
#include <cuda_runtime.h>
#include <cuda_runtime_api.h>
#include <device_launch_parameters.h>

#include <cmath>
#include <stdio.h>
double * cudaSamples;
double * cudaDFT;
__managed__ int N;

__global__
void kernelDFT(double * samples, double * DFT){
    int index = threadIdx.x + blockDim.x*blockIdx.x;
    if(index > N){
        printf("Thread exit\n");
        return;
    }

    double real = 0;
    double imag = 0;
    for(int i = 0; i < N; i++){
        real += samples[i]*cos(2.0*3.14159265* (float) index * (float) i / (float) N);
        imag -= samples[i]*sin(2.0*3.14159265* (float) index * (float) i / (float) N);
    }

    DFT[index] = sqrt(real*real + imag*imag)/(index == 0 ? N : N>>1);
}

void DFT(double * samples){
    cudaMemcpy(cudaSamples, samples, sizeof(double)*N, cudaMemcpyHostToDevice);
    kernelDFT<<<1, 1024>>>(cudaSamples, cudaDFT);
    cudaDeviceSynchronize();
    cudaError_t err = cudaMemcpy(samples, cudaDFT, sizeof(double)*N, cudaMemcpyDeviceToHost);
    if(err)
        printf("%s\n", cudaGetErrorString(err));
}

void cudaInit(int num){
    N = num;
    cudaMalloc(&cudaSamples, sizeof(double)*N);
    cudaMalloc(&cudaDFT, sizeof(double)*N);
}

void cudaExit(){
    cudaFree(cudaSamples);
    cudaFree(cudaDFT);
}