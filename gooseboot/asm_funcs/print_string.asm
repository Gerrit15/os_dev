[bits 32]
;consts
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:
  pusha
  ;make edx a pointer to vga text buffer
  mov edx, VIDEO_MEMORY

print_string_pm_loop:
  ; store character in ah
  mov al, [ebx]
  ; store color in al
  mov ah, WHITE_ON_BLACK

  ; null terminated things
  cmp al, 0
  je print_string_pm_done

  ; send colored characters to screen
  mov [edx], ax

  add ebx, 1    ; incriment string pointer
  add edx, 2    ; incriment vga pointer by two because cells are color and text

  jmp print_string_pm_loop

print_string_pm_done:
  popa
  ret
