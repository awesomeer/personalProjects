#include <iostream>
#include <cmath>
#include "filt.h"

#define dt .000008

using namespace std;

int main(int argc, char * argv[]){
    Filter bandpass(BPF, 1000, 1/dt, 60.0/1000.0, 250.0/1000.0);
    int input[1000];
    double output[1000];
    for(int i = 0; i < 1000; i++){
        input[i] = 4095 * sin(60.0 * 2 * M_PI * (float) i * dt);
        output[i] = bandpass.do_sample((double) input[i]);
    }
    bandpass.write_freqres_to_file("freqres.txt");
    bandpass.write_taps_to_file("taps.txt");


    double ouA = 0;
    for(double add : output){
        ouA += add;
    }
    cout << ouA/1000 << endl;
}