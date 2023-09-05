# A very basic operating system
This is my senior capstone, I will be researching how a basic operating system works. 
Because it is my capstone, I will be writing it in my preferred language, Rust. That being said, most traditional operating systems are built for C or in *fancier cases* C++

## Goals
- [ ] Understand the purpose of an operating system.
    - [ ] What is BIOS
    - [ ] What is system management
    - [ ] What is paging
    - [ ] Users vs Hardware
- [ ] Create a minimum Viable OS 
    - [ ] Create a BIOS based bootloader
    - [ ] Impliment text mode
    - [ ] Impliment Paging
    - [ ] Real mode/barebones
- [ ] Stretch goals
    - [ ] User interaction
    - [ ] File system reader
    - [ ] User executable programs, similar to `cat` and `ls`
    - [ ] protected mode (very well impossible)

## notes
- minimum viable means that is executable, and reaches protected mode
- outline can and will change as more research is done
- as there are not that many resources, there might not be that many sources
- Operating systems exist in a very nebulous space, and as such definitions can be wobbly. Everything here is human defined

## Sources
1. [OS Dev Wiki](https://wiki.osdev.org/Main_Page)
2. [Pillipp Opperman's "Writing an OS in Rust" Blog](https://os.phil-opp.com/) 
