[org 0x7c00]

mov bp, 0x8000
mov sp, bp

pusha
mov bx, String
call print_string
popa


end:
  mov ah, 0x0e
  mov al, 0x1
  int 0x10
  jmp $

; uses bx as it's pointer
print_string:
  mov ah, 0x0e
  print_cont:
    mov al, [bx]
    cmp al, 0
    je print_end
    int 0x10
    inc bx
    jmp print_cont
  print_end:
    ret

String:
  db "Hello, World!", 0

times 510-($-$$) db 0
dw 0xaa55
