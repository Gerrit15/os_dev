# what the comp_launch script looked like
#	nasm gooseboots.asm -f elf64 -o gooseboots.o
#	ld -o goosekernel.bin -Ttext 0x7c00 gooseboots.o --oformat binary
#	qemu-systeem-x86_64
gooseboots.o:
	nasm gooseboots.asm -f elf64 -o gooseboots.o

clean:
	rm -f gooseboots.o goosekernel.bin
