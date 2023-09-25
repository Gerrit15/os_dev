#this is probably depreciated, but it might be nice to have something to launch without cargo run
qemu-system-x86_64 -drive format=raw,file=target/x86_64-goose/debug/bootimage-goose.bin
