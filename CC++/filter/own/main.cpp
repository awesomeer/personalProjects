#include <iostream>
#include <math.h>
#include <fstream>

#define n 512
#define dt 0.000025

using namespace std;

void lowPass(double * input, double * output, int points){
    double RC = 1.0/(250.0 * 2.0 * M_PI);
    double alpha = (double) dt/(RC+dt);
    output[0] = input[0];
    for(int i = 1; i < points; ++i){
        output[i] = output[i-1] + (alpha * (input[i] - output[i-1]));
    }
}

/*
ff = fundatmental frequency sampleingFrequency/points
fs = sampling frequency
points = length of in
ft = frequency to test
in = points to data array
*/
double DFT(double * in, double fs, int points, double ft){
    double ff = fs/points;
    double m = ft/ff;
    double real = 0, imag = 0;

    for(int i = 0; i < points; i++){
        double argu = (2.0 * M_PI * (float) i * m) / points;
		double w = 0.5 - 0.5*cos(2*M_PI*i/points);
        real += in[i] * cos(argu) * w;
        imag -= in[i] * sin(argu) * w;
    }
    
    return sqrt(pow(real,2) + pow(imag,2));
}

int main(){

    double input[n];

    cout << "main: loop" << endl;
	ifstream in("in.txt", ifstream::in);
    for(int i = 0; i < n; i++){
		in >> input[i];
        cout << input[i] << endl;
    }


    ofstream out("data.txt", ofstream::out);
    cout << "Magnitudes" << endl;
    for(int i = 1; i <= 20000; i++){
        double mag = DFT(input, 1/dt, n, i)/n;
        out << mag << endl;
        switch(i){
            case 1:
            case 2000:
            case 5000:
            case 10000:
                cout << mag << endl;
        }
    }

    out.close();
    return 0;
}
