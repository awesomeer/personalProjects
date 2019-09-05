#include "../../include/CImg.h"
#include <iostream>

using namespace std;
using namespace cimg_library;

#define R(row, col, width, height) ((row*width)+col)
#define G(row, col, width, height) ((width*height) + ((row*width)+col))
#define B(row, col, width, height) ((2*width*height) + ((row*width)+col))
#define M(row, col, width) ((row*width)+col)

int main(int argc, char ** argv){
    if(argc < 2){
        cout << "inadequate arguments" << endl;
        exit(1);
    }

    CImg<unsigned char> file(argv[1]);
    CImg<unsigned char> image(file.width(), file.height(), 1, 3, 0);

    int w = image.width();
    int h = image.height();
    unsigned char * imageP = image.data();
    unsigned char * fileP = file.data();
    if(file.spectrum() != 3){
        for(int i = 0; i < image.height(); i++){
            for(int j = 0; j < image.width(); j++){
                switch(file.spectrum()){
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
        memcpy(image.data(), file.data(), file.size());
    }

    cout << file.height() << " " << file.width() << " " << file.spectrum() << " " << file.size() << endl;

    // for(int i = 0; i < image.height(); i++){
    //     for(int j = 0; j < image.width(); j++){
    //         if(i < image.height()/4 && j < image.width()/4)
    //             image.data()[B(i,j, image.width(), image.height())] = 255;    
    //         else if(i < image.height()/2 && j < image.width()/2)
    //             image.data()[G(i,j, image.width(), image.height())] = 255;
    //         else
    //             image.data()[R(i,j, image.width(), image.height())] = 255;
    //     }
    // }

    CImgDisplay dis(image, "test");
    dis.show();
    while(!dis.is_closed());

}