;this is because our labels don't account for correct location, this is our proper offset
[org 0x7c00]

; set up stack just a little below the bootloader
mov bp, 0x8000
mov sp, bp
pusha
%include "print_string.asm"
mov bx, String
call print_string
popa

end:
  jmp $

String:
  db "Hello, world!", 0


times 510-($-$$) db 0
dw 0xaa55
