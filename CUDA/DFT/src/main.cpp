#include <iostream>
#include <cmath>

#include "..\inc\kernel.h"

#define SIZE 1024
#define FS 40960.0


using namespace std;
double data12[SIZE];
int main(int argc, char ** argv){

        
    for(int i = 0; i < SIZE; i++){
        data12[i] = 64*sin(40.0 * 2.0 * 3.1415926 * (double) i / FS);
        data12[i] += 32*sin(120.0 * 2.0 * 3.1415926 * (double) i / FS);
        data12[i] += 32*sin(120.0 * 2.0 * 3.1415926 * (double) i / FS);

    }

    cudaInit(SIZE);
    DFT(data12);
    cudaExit();

    for(int i = 0; i < SIZE/2; i++){
        cout << data12[i] << endl;
    }

    return 0;
}