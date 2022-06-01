#include "gaussian.h"
#include <vector>
#include "convolution.hpp"

float gaussian[25] = {  1, 4, 6, 4, 1,
		                4, 16, 24, 16, 4,
		                6, 24, 36, 24, 6,
                        4, 16, 24, 16, 4,
		                1, 4, 6, 4, 1 };

void gaussianInit() {
    for(int i = 0; i < 25; i++)
        gaussian[i] /= 256;
}

void gaussianFilter(uint8_t* frame, size_t rows, size_t cols) {
    std::vector<RGB> buf((RGB*)frame, (RGB*)frame + rows * cols);
    convolve(buf.data(), (RGB*)frame, { cols, rows }, gaussian, { 5, 5 }, { -2, -2 });
}

void gaussianFree() {
    // Not used
}