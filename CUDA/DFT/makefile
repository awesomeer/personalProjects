all: dft.exe

dft.exe: obj\main.o obj\kernel.o
	nvcc obj\main.o obj\kernel.o -o dft.exe
obj\main.o: src\main.cpp
	nvcc -g -c src\main.cpp -o obj\main.o
obj\kernel.o: src\kernel.cu inc\kernel.h
	nvcc -g -c src\kernel.cu -o obj\kernel.o