
kernel.bin: entry.o main.o
	ld -o kernel.bin -e 0x1000 entry.o main.o --oformat binary

entry.o: src/entry.asm
	nasm src/entry.asm -f elf -o entry.o

main.o: src/main.c
	gcc -ffreestanding -c src/main.c -o main.o