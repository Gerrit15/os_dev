# what the comp_launch script looked like
#	nasm gooseboots.asm -f elf64 -o gooseboots.o
#	ld -o goosekernel.bin -Ttext 0x7c00 gooseboots.o --oformat binary
#	qemu-system-x86_64 -boot a -fda goosekernel.bin

# essentially what's happening here is it calls the "final" file, but 
# the final file requires goosekernel.bin, and the kernel requires gooseboots.o
# and so it all runs, kinda cascadingly

boot := gooseboots.asm
kernel_rs := target/x86_64-goose/debug/Goose

all: final

gooseboots.o:
	@nasm ${boot} -f elf64 -o gooseboots.o

goosekernel.bin: gooseboots.o Goose
	@ld -o goosekernel.bin -Ttext 0x7c00 -e "_goose_start" gooseboots.o ${kernel_rs} --oformat binary
	@rm gooseboots.o

Goose: 
	cargo build

final: goosekernel.bin
	@qemu-system-x86_64 -boot a -fda goosekernel.bin
