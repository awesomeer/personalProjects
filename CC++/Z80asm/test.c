#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>

#define step 2.0*3.14159265/256.0
#define one 2.0*3.14159265/3.0
#define two 4.0*3.14159265/3.0
int main(int argc, char ** argv){

    for(int count = 0; count < 256; count++){
        printf("%d, ", abs(255*(0.5*cos(count*step+two)+0.5)));
        //printf("%d %d %d\n", abs(255*(0.5*cos(count*step)+0.5)), abs(255*(0.5*cos(count*step+one)+0.5)), abs(255*(0.5*cos(count*step+two)+0.5)));
    }
    return 0;
}