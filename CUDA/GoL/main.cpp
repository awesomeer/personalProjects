#include <iostream>
#include "../../include/CImg.h"
#include <chrono>

using namespace std;
using namespace cimg_library;

#define WIDTH 1600
#define HEIGHT 900
#define SIZE WIDTH*HEIGHT

extern void randomize(int size);
extern void initCUDA(int size);
extern void iteration(unsigned char * data, int width, int height);
extern void exitCUDA();

int main(){
	srand((unsigned int) time(NULL));
	CImg<unsigned char> image = CImg<unsigned char>(WIDTH, HEIGHT,1,3,0);
	CImgDisplay display(image, "Game of Life");
	chrono::system_clock::time_point start,end;
	chrono::duration<double> time;

	initCUDA(SIZE);

	display.display(image);
	//iteration(image.data(), WIDTH, HEIGHT);
	//display.set_fullscreen(true, true);

	
	while(!display.is_closed()){
		start = chrono::system_clock::now();

		if(display.is_keyESC())
			break;

		if(display.is_keyR())
			randomize(SIZE);
		
		if(display.is_keyT())
			display.toggle_fullscreen();

		iteration(image.data(), WIDTH, HEIGHT);
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
