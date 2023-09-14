[bits 32]

; some consts
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; prints a null terminated string into edx
print_string_pm:
  pusha
  mov edx, VIDEO_MEMORY ; sets edx to start of vid memory

print_string_pm_loop:
  mov al, [ebx]             ; put the character in ebx in al
  mov ah, WHITE_ON_BLACK    ; put a color in ah

  cmp al, 0                 ; null terminated and all that
  je print_string_pm_done

  move [edx], ax            ; otherwise print to current position

  add ebx, 1                ; next character
  add ebx, 2                ; next cell (each cell is color and character)

  jmp print_string_pm_loop

print_string_pm_done:
  popa
  ret
