#include <iostream>
#include "../../include/CImg.h"
#include <chrono>

using namespace std;
using namespace cimg_library;

#define WIDTH 1600
#define HEIGHT 900

extern void initCUDA(int size, bool * data);
extern void iteration(bool * data, int width, int height);
extern void exitCUDA();


void initGoL(CImg<bool>& image){
	bool * data = image.data();
	
	for(int i = 0; i < image.size(); i++){
		if(rand() < (RAND_MAX/2)){
			data[i] = true;
		}
		else{
			data[i] = false;
		}
	}
}

int main(){
	srand(time(NULL));
	CImg<bool> image = CImg<bool>(WIDTH, HEIGHT,1,1,0);
	CImgDisplay display(image, "Game of Life");
	chrono::system_clock::time_point start,end;
	chrono::duration<double> time;

	initGoL(image);
	initCUDA(image.size(), image.data());

	display.display(image);
	iteration(image.data(), WIDTH, HEIGHT);
	display.set_fullscreen(true, true);

	
	while(!display.is_closed()){
		start = chrono::system_clock::now();

		if(display.is_keyESC())
			break;

		if(display.is_keyR())
			initGoL(image);
		
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
