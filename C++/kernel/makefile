SRC := $(wildcard src/*.c)
OBJ := $(patsubst src/%.c, %.o, $(SRC))

CFLAGS = -g -std=c99 -m32 -fno-pie -ffreestanding



all: code clean

run: 
	qemu-system-i386 os-image

code: kernel.bin




kernel.bin: entry.o $(OBJ)
	ld -m elf_i386 -o kernel.bin -e 0x1000 entry.o $(OBJ) --oformat binary
	python3 createImage.py

$(OBJ): $(SRC)
	gcc $(CFLAGS) -c $(patsubst %.o, src/%.c, $@) -o $@

entry.o: src/entry.asm
	nasm -Ov -f elf32 -o $@ $<




clean:
	rm -f *.o *.bin

clean_git: clean
	rm  -f os-image*
