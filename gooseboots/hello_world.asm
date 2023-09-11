[org 0x7c00]
mov ah, 0xe
mov bx, Hworld

printString:
  mov al, [bx]
  cmp al, 0
  je end
  int 0x10
  inc bx
  jmp printString

end:
  jmp $

Hworld:
  db "Hello, World!", 0

times 510-($-$$) db 0
dw 0xaa55
