g++ -c -g asm.cpp
g++ -c -g main.cpp
g++ -g main.o asm.o
del *.o