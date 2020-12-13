#include "../../include/CImg.h"
#include "kernel.h"
#include <iostream>

#define ARGS 0

using namespace std;
using namespace cimg_library;


#define DEFAULT_WIDTH 800
#define DEFAULT_HEIGHT 600


int main(int argc, char** argv) {

	int width = DEFAULT_WIDTH;
	int height = DEFAULT_HEIGHT;
	
#if ARGS
	if (argc > 2) {
		if (atoi(argv[1]) != 0)
			width = atoi(argv[1]);
		if (atoi(argv[2]) != 0)
			height = atoi(argv[2]);
	}
#endif

	CImg<unsigned char> world = CImg<unsigned char>(DEFAULT_WIDTH, DEFAULT_HEIGHT, 1, 3, 0);
	CImgDisplay display = CImgDisplay(world, "Game of Life");

	initCUDA(width, height);
	display.display(world);


	while (!display.is_closed() && !display.is_keyESC()) {

		Sleep(16);
		iterate(world.data());
		display.render(world);
		display.paint();

	}


	freeCUDA();
	return 0;
}


