SRC := $(wildcard src/*.c)
OBJ := $(patsubst src/%.c, %.o, $(SRC))

CFLAGS = -g -std=c99 -m32 -fno-pie -ffreestanding


all: code clean

code: kernel.bin

kernel.bin: $(OBJ)
	ld -m elf_i386 -o kernel.bin -e 0x1000 $(OBJ) --oformat binary
	python3 createImage.py

$(OBJ): $(SRC)
	gcc $(CFLAGS) -c $< -o $@


clean:
	rm -f *.o \
	   	  *.dis

clean_git: clean
	rm  -f os-image* \
		   kernel.*
