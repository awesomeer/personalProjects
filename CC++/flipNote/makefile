run: FlipNote.o main.o
	g++ main.o FlipNote.o -lX11 -pthread -o run
main.o: main.cpp
	g++ -c main.cpp -lX11
FlipNote.o: FlipNote.cpp FlipNote.hpp
	g++ -c FlipNote.cpp -lX11
