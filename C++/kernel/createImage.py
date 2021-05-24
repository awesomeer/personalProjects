import os

#80x25
infile = open('kernel.bin', 'rb')
outfile = open('kernel-short.bin', 'wb')

infile.read(0x1000)
outfile.write(infile.read())

infile.close()
outfile.close()

#os.system('ndisasm -u kernel-short.bin > kernel.asm')
os.system('cat ../OS/boot_sect.bin kernel-short.bin > os-image')
os.system('ndisasm -u os-image > os-image.asm')

os.system('rm kernel-short.bin')
os.system('rm kernel.bin')


"""
all: kernel.bin clean

code: kernel.bin

kernel.bin: main.o stdio.o
	ld -m elf_i386 -o kernel.bin -e 0x1000 main.o stdio.o --oformat binary
	python3 createImage.py

main.o: src/main.c
	gcc -g -std=c99 -m32 -fno-pie -ffreestanding -c src/main.c -o main.o
	objdump -d -S main.o > main.dis

stdio.o: src/stdio.c
	gcc -g -std=c99 -m32 -fno-pie -ffreestanding -c src/stdio.c -o stdio.o
	objdump -d -S stdio.o > stdio.dis

clean:
	rm -f *.o \
	   	  *.dis

clean_git: clean
	rm  -f os-image* \
		   kernel.*
"""