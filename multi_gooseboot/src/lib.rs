#![no_std]
use core::panic::PanicInfo;
extern crate rlibc;


#[no_mangle]
pub extern "C" fn rust_main() {
    let buff = (0xb8000) as *mut _;
    unsafe {*buff = 0x2f59};
    loop {}
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
