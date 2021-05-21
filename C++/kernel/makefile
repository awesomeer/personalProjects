all: kernel.bin clean

code: kernel.bin

kernel.bin: main.o stdio.o
	ld -m elf_i386 -o kernel.bin -e 0x1000 main.o stdio.o --oformat binary
	python3 createImage.py

main.o: src/main.c
	gcc -g -m32 -fno-pie -ffreestanding -c src/main.c -o main.o

stdio.o: src/stdio.c
	gcc -g -m32 -fno-pie -ffreestanding -c src/stdio.c -o stdio.o

clean:
	rm *.o

clean_git:
	rm *.o | rm os-image | rm kernel.*