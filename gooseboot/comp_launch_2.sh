nasm goo.asm -f elf64 -o goo.o
ld -o  gookernel.bin -Ttext 0x1000 goo.o --oformat binary
qemu-system-x86_64 -boot a -fda gookernel.bin
