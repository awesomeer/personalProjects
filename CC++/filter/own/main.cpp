#include <iostream>
#include <math.h>
#include <fstream>

#define w0 3000
#define n 100
#define dt .000008

using namespace std;

void lowPass(double * input, double * output, int points){
    double RC = 1.0/(250.0 * 2.0 * M_PI);
    double alpha = (double) dt/(RC+dt);
    //cout << alpha << endl;
    output[0] = input[0];
    for(int i = 1; i < points; ++i){
        output[i] = output[i-1] + (alpha * (input[i] - output[i-1]));
    }
}

/*
ff = fundatmental frequency sampleingFrequency/points
fs = sampling frequency
ppints = length of in
ft = frequency to test
in = points to data array
*/
double DFT(double * in, double fs, int points, double ft){
    double ff = fs/points;
    double m = ft/ff;
    double real = 0, imag = 0;

    for(int i = 0; i < points; i++){
        double argu = (2.0 * M_PI * (float) i * m) / points;
        real += in[i] * cos(argu);
        imag -= in[i] * sin(argu);
    }
    
    return sqrt(pow(real,2) + pow(imag,2));
}

int main(){

    double input[n];

    cout << "main: loop" << endl;
    for(int i = 0; i < n; i++){
        double one = 2.0 * M_PI * dt * w0;
        input[i] = 4095.0 * sin((double) i * one);
        cout << input[i] << endl;
                 //+ (1.7 * abs(sin(4.0 * w0 * ((float) i * dt))))
                 //+ (1.7 * abs(cos(3.0 * w0 * ((float) i * dt))));
    }
    
    /*while(1){
        double ft;
        cout << "Enter frequency to test: ";
        cin >> ft;
        double mag = DFT(input, 1/dt, n, ft);

        cout << "Magnitude\n" << mag/100 << endl;
    }*/


    ofstream out("data.txt", ofstream::out);
    for(int i = 1; i <= 20000; i++){
        double mag = DFT(input, 1/dt, n, i)/n;
        out << mag << endl;
    }
    out << endl << endl;
    for(int i = 1; i <= 20000; i++){
        out << i << endl;
    }
    out.close();
    return 0;
}