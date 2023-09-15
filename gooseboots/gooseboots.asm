[org 0x7c00]
mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string_rm

call switch_to_pm

jmp $

%include "print_string_rm.asm"
%include "print_string.asm"
%include "gdt.asm"
%include "switch_to_pm.asm"
%include "cpuid_check.asm"
%include"long_mode_check.asm"

[bits 32]
BEGIN_PM:
mov ebx, MSG_PROT_MODE
call print_string_pm

call check_cpuid
call check_long_mode
mov ebx, MSG_LONG_MODE_AVAIL
call print_string_pm


end:
  jmp $

MSG_REAL_MODE:
  db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE:
  db "Reached 32-bit Protected Mode", 0
MSG_LONG_MODE_AVAIL:
  db "Long mode is available", 0

error:
  mov dword [0xb8000], 0x4f524f45
  mov dword [0xb8004], 0x4f3a4f52
  mov dword [0xb8008], 0x4f204f20
  mov byte  [0xb800a], al
  hlt

times 510-($-$$) db 0
dw 0xaa55
