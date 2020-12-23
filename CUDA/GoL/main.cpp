#include "../../include/CImg.h"
#include "kernel.h"
#include <iostream>
#include <chrono>


#define DEFAULT_WIDTH 1920
#define DEFAULT_HEIGHT 1080

#define LIMITFPS 1
#define FPSLIMIT 60.0

using namespace std;
using namespace cimg_library;

int main(int argc, char** argv) {

	int width = DEFAULT_WIDTH;
	int height = DEFAULT_HEIGHT;
	
	if (argc > 2) {
		if (atoi(argv[1]) != 0)
			width = atoi(argv[1]);
		if (atoi(argv[2]) != 0)
			height = atoi(argv[2]);
	}

	CImg<unsigned char> world = CImg<unsigned char>(DEFAULT_WIDTH, DEFAULT_HEIGHT, 1, 3, 0);
	CImgDisplay display = CImgDisplay(world, "Game of Life");

	srand((unsigned int)time(NULL));
	initCUDA(width, height);
	display.display(world);


	chrono::system_clock::time_point start, end;
	chrono::duration<double> time;

	bool play = true;
	while (!display.is_closed() && !display.is_keyESC()) {

		start = chrono::system_clock::now();

		if (display.is_keyR())
			randomize();

		if (display.is_keyT())
			display.toggle_fullscreen();

		if (display.is_keyP())
			play = !play;

		if (play) {
			iteration(world.data());
			display.render(world);
			display.paint();
		}

		do {
			end = chrono::system_clock::now();
			time = end - start;
		} while ((time.count() < 1.0 / FPSLIMIT) && LIMITFPS);

		cout << 1 / time.count() << endl;

	}

	if (!display.is_closed())
		display.close();

	freeCUDA();
	return 0;
}


