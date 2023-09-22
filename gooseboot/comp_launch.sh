nasm gooseboots.asm -f bin -o gooseboots.bin;
qemu-system-x86_64 -boot a -fda gooseboots.bin;
