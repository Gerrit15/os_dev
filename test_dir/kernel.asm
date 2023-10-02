global _goose_start
section .text
_goose_start:
extern _start
call _start
mov ah, 0x0e
mov al, "x"
int 0x10
times 510-($-$$) db 0
dw 0xaa55
