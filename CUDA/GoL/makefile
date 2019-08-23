run: main.o kernal.o
	nvcc -g main.o kernal.o -o run -lX11
main.o: main.cpp
	nvcc -g -c main.cpp -o main.o
kernal.o: kernal.cu
	nvcc -g -c kernal.cu -o kernal.o
