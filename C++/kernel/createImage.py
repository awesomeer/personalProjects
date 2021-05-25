import os

#80x25
infile = open('kernel.bin', 'rb')
outfile = open('kernel-short.bin', 'wb')

infile.read(0x1000)
outfile.write(infile.read())

infile.close()
outfile.close()

os.system('cat ../OS/boot_sect.bin kernel-short.bin > os-image')
os.system('ndisasm -u os-image > os-image.dis')
