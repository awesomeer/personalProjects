#include "../../include/CImg.h"
#include <iostream>

using namespace std;
using namespace cimg_library;

#define R(row, col, width, height) ((row*width)+col)
#define G(row, col, width, height) ((width*height) + ((row*width)+col))
#define B(row, col, width, height) ((2*width*height) + ((row*width)+col))
#define M(row, col, width) ((row*width)+col)

extern void XOR(unsigned char * dest, unsigned char * src, int row, int col);

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
    CImg<unsigned char> file(argv[1]);
    CImg<unsigned char> image(file.width(), file.height(), 1, 3, 0);
    CImg<unsigned char> output(file.width(), file.height(), 1, 3, 0);
    imageConvert(file, image);
    memcpy(output.data(), image.data(), image.size());

    //XOR(output.data(), image.data(), image.height(), image.width());

    CImgDisplay display(output, "test");
    display.show();
    while(1){
        //sleep(1);
        if(display.is_key0()){
            cout << "if" << endl;
            while(display.is_key0());
            XOR(output.data(), output.data(), image.height(), image.width());
            display.render(output);
            display.paint();
        }
    }



    return 0;
}