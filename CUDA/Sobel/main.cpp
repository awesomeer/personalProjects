
#include <opencv2/opencv.hpp>
#include <opencv2/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/highgui.hpp>

#include "kernel.h"
#include <iostream>
using namespace std;
using namespace cv;





int main(int argc, char** argv) {

	VideoCapture camera;

	if (argc > 1)
		camera.open(argv[1]);
	else
		camera.open(0);

	if (!camera.isOpened())
		return -1;
	camera.set(CAP_PROP_FRAME_WIDTH, 1920);
	camera.set(CAP_PROP_FRAME_HEIGHT, 1080);


	Mat cap;
	initCuda();
	namedWindow("Video Stream");
	resizeWindow("Video Stream", 1920, 1080);
	

	while (true) {
		camera >> cap;
		if (cap.empty())
			break;
		
		filter(cap.data);
		imshow("Video Stream", cap);

		if (waitKey(10) == 27)
			break;
	}
	unsigned char* data = cap.data;
	cout << cap.size << endl;

	freeCuda();

	return 0;
}