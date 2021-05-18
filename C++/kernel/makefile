all: kernel.bin clean

code: kernel.bin

kernel.bin: main.o
	ld -m elf_i386 -o kernel.bin -e 0x1000 main.o --oformat binary
	python3 createImage.py

main.o: src/main.c
	gcc -m32 -fno-pie -ffreestanding -c src/main.c -o main.o

clean:
	rm *.o

clean_git:
	rm *.o | rm os-image | rm kernel.*