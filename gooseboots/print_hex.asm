;; ascii '0'-'9' = hex 0x30-0x39
;; ascii 'A'-'F' = hex 0x41-0x46
;; ascii 'a'-'f' = hex 0x61-0x66

print_hex:
  pusha
  mov ah, 0x0e
  mov cx, 0

  hex_loop:
    cmp cx, 4
    je end_hex

    mov ax, dx
    and ax, 0x000F         ; masks everything but the first character (or last, depending on perspective)
    add al, 0x30         
    cmp al, 0x39           ; looking at the bottom two hex values, if it's  <= it's a number, otherwise it's a character
    jle hex_mv_to_bx
    add al, 0x7            ; to get our ascii 'A' through 'F', this works because it shifts
    hex_mv_to_bx:
    mov bx, hex_string + 5 ; base address of string + string len
    sub bx, cx             ; subtract iterator value
    add cx, 1              ; if it fucks up, this is the issue
    mov [bx], al           ; actually assign the value into our string
    ror dx, 4              ; rotate right by 4 bits, like a carousel, so like 0x1234 -> 0x4123 (only does this for hex because 4 bits because 2^4)
    jmp hex_loop

  end_hex:
    mov bx, hex_string     ; have to actually put the 0x into it
    call print_string
    popa
    ret

hex_string: 
  db "0x0000", 0
