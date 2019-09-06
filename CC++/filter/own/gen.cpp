#include <fstream>
#include <iostream>
#include <cmath>


using namespace std;

#define f0 2000
#define f1 10000
#define f2 5000
#define dt 0.000025

int main(){
    ofstream out("in.txt", ofstream::out);
    int waves[3] = {f0, f1, f2};

    for(int i = 0; i < 834; i++){
        int O0 = 200*sin(2*M_PI*waves[0]*i*dt);
        int O1 = 232*cos(2*M_PI*waves[1]*i*dt);
        int O2 = 433*sin(2*M_PI*waves[2]*i*dt);
        out << (O0+O1+O2) << endl;
    }

    out.close();

}