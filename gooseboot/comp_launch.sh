nasm gooseboots.asm -f elf64 -o gooseboots.o
ld -o  goosekernel.bin -Ttext 0x7c00 gooseboots.o --oformat binary
qemu-system-x86_64 -boot a -fda goosekernel.bin
