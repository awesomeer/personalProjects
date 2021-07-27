SRC := $(wildcard src/*.c)
OBJ := $(patsubst src/%.c, %.o, $(SRC))

VER = riscv32-unknown-elf

CC = $(VER)-gcc
LD = $(VER)-ld

LIB_PATH = 	-L"/opt/riscvim/lib" \
			-L"/opt/riscvim/lib/gcc/riscv32-unknown-elf/11.1.0" \
			-L"/opt/riscvim/riscv32-unknown-elf/lib"

CCFLAGS = -g -c -ffreestanding -nostartfiles -O2
LIB_ARG = -Wl,-T lnks.ld -lm


main: entry.o $(OBJ)
	$(CC) -o main entry.o $(OBJ) -ffreestanding -nostartfiles $(LIB_ARG)
	$(VER)-objdump -S -d main > copy

	$(VER)-readelf main -x 1 > hex.txt
	python3 rom.py hex.txt > memrom.txt

	$(VER)-readelf main -x 2 > hex.txt
	python3 rom.py hex.txt > memrom.txt

entry.o: entry.c
	$(CC) $(CCFLAGS) -o $@ $<

$(OBJ): $(SRC)
	$(CC) $(CCFLAGS) -o $@ $(patsubst %.o, src/%.c, $@)


clean:
	rm *.o main