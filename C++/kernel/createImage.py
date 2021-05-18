import os


infile = open('kernel.bin', 'rb')
outfile = open('kernel-short.bin', 'wb')

infile.read(0x1000)
outfile.write(infile.read())

infile.close()
outfile.close()

os.system('ndisasm -u kernel-short.bin > kernel.dis')
os.system('cat ../OS/boot_sect.bin kernel-short.bin > os-image')

infile = open('os-image', 'ab')
infile.write(bytearray(0x1000))
infile.close

os.system('rm kernel-short.bin')
os.system('rm kernel.bin')
