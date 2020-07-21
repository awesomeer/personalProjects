#include <iostream>
#include <cstdlib>
#include "../../include/CImg.h"
#include <chrono>

using namespace std;
using namespace cimg_library;

#define DEFAULT_WIDTH 1600/2
#define DEFAULT_HEIGHT 900/2

extern void randomize(int size);
extern void initCUDA(int size);
extern void iteration(unsigned char * data, int width, int height);
extern void exitCUDA();

int main(int argc, char ** argv){
	int width = 0, height = 0, size;
	if (argc > 2) {
		width = atoi(argv[1]);
		height = atoi(argv[2]);
	}
	if (width == 0)
		width = DEFAULT_WIDTH;
	if (height == 0)
		height = DEFAULT_HEIGHT;

	size = width * height;

	srand((unsigned int) time(NULL));
	CImg<unsigned char> image = CImg<unsigned char>(width, height,1,3,0);
	CImgDisplay display(image, "Game of Life");

	chrono::system_clock::time_point start,end;
	chrono::duration<double> time;

	initCUDA(size);

	display.display(image);
	
	while(!display.is_closed() && !display.is_keyESC()){
		start = chrono::system_clock::now();

		if(display.is_keyR())
			randomize(size);
		
		if(display.is_keyT())
			display.toggle_fullscreen();

		iteration(image.data(), width, height);
		display.render(image);
		display.paint();

		do{
			end = chrono::system_clock::now();
			time = end-start;
		}while(time.count() < 1.0/60.0);

		cout << 1/time.count() << endl;
	}

	if(!display.is_closed())
		display.close();
	exitCUDA();
	cout << "mem freed" << endl;
}
