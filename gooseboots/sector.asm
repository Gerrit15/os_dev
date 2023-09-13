; this is a nifty asm file to show how sector offsetting can work

mov ah, 0x0e

; this doesn't work because we haven't 'org'ed this program, it's starting at the wrong spot
; therefore
mov al, [the_secret]
int 0x10

mov bx, 0x7c0
mov ds, bx
mov al, [the_secret]
int 0x10

mov al, [es:the_secret]
int 0x10

mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10

jmp $

the_secret:
  db "x"

times 510-($-$$) db 0
dw 0xaa55
