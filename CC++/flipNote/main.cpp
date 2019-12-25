#include "FlipNote.hpp"
#include "../../include/CImg.h"
#include <iostream>

using namespace std;
using namespace cimg_library;

int main(int argc, char ** argv){
    CImg<unsigned char> frame = FlipNote::getPrevew(*(new string(argv[1])));
    CImgDisplay dis(frame, "test");

    dis.display(frame);
    while(!dis.is_closed());
}