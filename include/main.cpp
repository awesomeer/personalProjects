#include <iostream>
#include "Complex.hpp"

int main(int argc, char ** argv){
	Complex<int> test(100, 400);
	std::cout << test << std::endl;
	return 0;
}