;this is because our labels don't account for correct location, this is our proper offset
[org 0x7c00]

; set up stack just a little below the bootloader
mov bp, 0x8000
mov sp, bp ; stack pointer and base pointer

mov bx, String
call print_string

mov dx, 0xA99A
call print_hex

end:
  jmp $

%include "print_string.asm"
%include "print_hex.asm"

String:
  db "Hello, world!", 0

times 510-($-$$) db 0
dw 0xaa55
