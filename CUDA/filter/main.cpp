#include "../../include/CImg.h"
#include <iostream>

using namespace std;
using namespace cimg_library;

#define R(row, col, width, height) ((row*width)+col)
#define G(row, col, width, height) ((width*height) + ((row*width)+col))
#define B(row, col, width, height) ((2*width*height) + ((row*width)+col))
#define M(row, col, width) ((row*width)+col)

extern void cudaLaunch(unsigned char * dest, unsigned char * src, int row, int col, int filter);
extern void initCuda(unsigned long size);
extern void cudaReset();


//Copies the image data from src to dest (ie pixel data) : converts greyscale to RGB also
void imageConvert(CImg<unsigned char> &src, CImg<unsigned char> &dest){
    int w = dest.width();
    int h = dest.height();
    unsigned char * imageP = dest.data();
    unsigned char * fileP = src.data();
    if(src.spectrum() != 3){
        for(int i = 0; i < dest.height(); i++){
            for(int j = 0; j < dest.width(); j++){
                switch(src.spectrum()){             //Maybe there will be more cases, just for the future
                    case 1:{
                        imageP[R(i,j,w,h)] = fileP[M(i,j,w)];
                        imageP[G(i,j,w,h)] = fileP[M(i,j,w)];
                        imageP[B(i,j,w,h)] = fileP[M(i,j,w)];
                    }
                }
            }
        }
    }
    else{
        memcpy(dest.data(), src.data(), src.size());
        cout << "copy" << endl;
    }
}

int main(int argc, char ** argv){
    if(argc < 2){
        cout << "inadequate arguments" << endl;
        exit(1);
    }

    CImg<unsigned char> file(argv[1]);
    CImg<unsigned char> image(file.width(), file.height(), 1, 3, 0);
    CImg<unsigned char> display(file.width(), file.height(), 1, 3, 0);

    imageConvert(file, image);
    memcpy(display.data(), image.data(), image.size());
    initCuda(display.size());

    //cudaReset();

    CImgDisplay dis(display, "output");
    dis.show();
    sleep(1);
    cudaLaunch(display.data(), image.data(), image.height(), image.width(), 0);
    // unsigned char * src = image.data();
    // unsigned char * dest = display.data();
    // int col = image.width();
    // int row = image.height();
    // for(int i = 0; i < image.height()-1; i++){
    //     for(int j = 0; j < image.width()-1; j++){
    //         int cRed = src[R(i, j, col, row)];
    //         int cGreen = src[G(i, j, col, row)];
    //         int cBlue = src[B(i, j, col, row)];
    //         //int cAverage = (cRed+cGreen+cBlue)/3;

    //         int red = src[R(i, j+1, col, row)];
    //         int green = src[G(i, j+1, col, row)];
    //         int blue = src[B(i, j+1, col, row)];
    //         //int average = (red+green+blue)/3;
    //         int average = (abs(cRed-red)+abs(cBlue-blue)+abs(cGreen-green))/3;
    //         if(average <= 10){
    //             dest[R(i, j, col, row)] = 0;
    //             dest[G(i, j, col, row)] = 0;
    //             dest[B(i, j, col, row)] = 0;
    //         }

    //     }
    // }

    dis.render(display);
    dis.paint();
    while(!dis.is_closed()){
        
        // char filter = -1;
        // if(dis.is_key0()){
        //     filter = 0;
        // }
        // cout << filter << endl;

        // if(filter != -1){
        //     cudaLaunch(display.data(), image.data(), image.height(), image.width(), filter);
        //     dis.render(display);
        //     dis.paint();
        // }

    }
}
