#![no_std]
#![no_main]
use core::panic::PanicInfo;

#[no_mangle]
#[export_name = "_start"]
pub extern "C" fn rust_main() {
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
