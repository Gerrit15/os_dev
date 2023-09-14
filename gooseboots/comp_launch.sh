nasm gooseboots.asm -f bin -o gooseboots.bin;
qemu-system-i386 -boot a -fda gooseboots.bin;
