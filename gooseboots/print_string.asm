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
