# A very basic operating system
This is my senior capstone, I will be researching how a basic operating system works. 
Because it is my capstone, I will be writing it in my preferred language, Rust. That being said, most traditional operating systems are built for C or in *fancier cases* C++

## Goals
- [ ] Understand the basic purpose of an operating system.
    - [x] What is BIOS
    - [x] What is system management
    - [x] What is paging
    - [x] Users vs Hardware
    - [ ] Understand text mode
    - [ ] How does the PCI bus function
    - [ ] Make a bootloader that can at least link Rust (does not have to connect to the rest of OS project)
- [ ] Create a minimum Viable OS 
    - [ ] Create a BIOS based Kernal
    - [ ] Impliment text mode (up to and including beyond our real mode setup)
    - [ ] Impliment Paging
    - [ ] Real mode/barebones
- [ ] Stretch goals
    - [ ] User interaction, such as keyboard
    - [ ] PCI bus interaction, and i2c for RAM
    - [ ] User executable programs, similar to `cat` and `ls`
    - [ ] Multi-level paging
    - [ ] Minesweeper a-la JDH (my biggest wish for this project)

## notes
- minimum viable means that is executable, and reaches protected mode
- outline can and will change as more research is done
- as there are not that many resources, there might not be that many sources
- Operating systems exist in a very nebulous space, and as such definitions can be wobbly. Everything here is human defined
- Currently, to expedite things, I'm using a tool to build a bootloader around the kernal, but I would like to make a basic bootloader at some point

## Sources
1. [OS Dev Wiki](https://wiki.osdev.org/Main_Page)
2. [Pillipp Opperman's "Writing an OS in Rust" Blog](https://os.phil-opp.com/) 
3. [Casey Cole's OS Series](https://www.youtube.com/watch?v=dFrDy8910j8&list=PLWCT05ePsnGww5psXWHRLG7p30eKKt1Pd)
