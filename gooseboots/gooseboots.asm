; for data sector, allows for proper offset
[org 0x7c00]

mov [BOOT_DRIVE], dl ; stores boot drive in dl, let's remember this for later

mov bp, 0x8000 ; set up stack just a little below the bootloader
mov sp, bp     ; stack pointer and base pointer

mov bx, String1
call print_string

mov bx, 0x9000           ; load 5 sectors to 0x0000(ES):0x9000(BX)
mov dh, 5                ; from boot disk (dl)
mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000 + 512]  ; a test, to see if we can make it access from beyond the 512 byte barrier
call print_hex

end:
  jmp $

%include "print_string.asm"
%include "print_hex.asm"
%include "disk_load.asm"

String1:
  ; 0xa is newline, 0xd is carriage return
  db "Attempting a load from disk!", 0xa, 0xd, 0

; global variable
BOOT_DRIVE: db 0

times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0
times 256 dw 0xface
