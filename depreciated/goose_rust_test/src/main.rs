#![no_std]
#![no_main]
use core::panic::PanicInfo;
//use core::fmt::Write;
mod vga_buffer;
//use vga_buffer::WRITER;

#[no_mangle]
pub extern "C" fn _start() -> ! {
    println!("Hello, world!");
    loop {}
}

#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    print!("{}", info);
    loop {}
}
