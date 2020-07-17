#include "../../include/CImg.h"
#include <string>
#include <vector>

#define PICPATH R"(C:\Users\mithi_000\Desktop\personalProjects\CC++\imageProcessing\pic.bmp)"

using namespace std;
using namespace cimg_library;



int main(int argc, vector<string> argv) {
	
	CImg<float> image = CImg<float>();
	image.load(PICPATH);


	CImgDisplay display(image, "TEST");

	display.display(image);
	while (!display.is_closed());

}