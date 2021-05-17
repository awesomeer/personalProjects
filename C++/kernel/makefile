
kernel.bin: entry.o main.o
	ld -m elf_i386 -o kernel.bin -e 0x1000 entry.o main.o --oformat binary
	ndisasm -u kernel.bin > kernel.dis

entry.o: src/entry.asm
	nasm src/entry.asm -f elf32 -o entry.o

main.o: src/main.c
	gcc -m32 -fno-pie -ffreestanding -c src/main.c -o main.o

clean:
	rm *.o
	rm kernel.*