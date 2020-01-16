#pragma once

#include "..\..\include\CImg.h"
#include <iostream>
#include <fstream>
#include <string>

using namespace std;
using namespace cimg_library;

class FlipNote{

    private:
        int animationSize;
        int audioSize;
        int numFrames;
        bool locked;
        int previewNum;
        string originalAuthor;
        string lastEdit;
        string userName;
        string originalAuthorId;
        string editAuthorId;
        string orginalFileName;
        string fileName;
        string prevEditAuthorId;
        long date;
        CImg<unsigned char> * frames;

    public:

        FlipNote();
        FlipNote(string fileName);

        static CImg<unsigned char> getPrevew(string fileName);
};