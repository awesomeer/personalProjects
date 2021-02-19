
#include <opencv2/opencv.hpp>
#include <opencv2/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/highgui.hpp>

#include "../inc/kernel.h"
#include <iostream>
using namespace std;
using namespace cv;





int main(int argc, char** argv) {

	VideoCapture camera(0);
	if (!camera.isOpened())
		return -1;
	camera.set(CAP_PROP_FRAME_WIDTH, 2000);
	camera.set(CAP_PROP_FRAME_HEIGHT, 2000);


	Mat cap;
	initCuda();
	namedWindow("Video Stream");
	

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