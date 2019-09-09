run: main.o kernal.o
	nvcc -g main.o kernal.o -lX11 -o run
main.o: main.cpp
	nvcc -g -c main.cpp -o main.o
kernal.o: kernal.cu
	nvcc -g -c kernal.cu -o kernal.o
