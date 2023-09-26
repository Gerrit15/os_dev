global _start
section .text
_start:
;[org 0x7c00]
mov bp, 0x9000
mov sp, bp
call switch_to_pm
jmp $

%include "./asm_funcs/gdt.asm"
%include "./asm_funcs/switch_to_pm.asm"

[bits 32]
BEGIN_PM:
jmp $
call check_cpuid
call check_long_mode

call longmode_prep
lgdt [GDT.Pointer]
jmp GDT.Code:Realm64


end:
  jmp $

error:
  mov dword [0xb8000], 0x4f524f45
  mov dword [0xb8004], 0x4f3a4f52
  mov dword [0xb8008], 0x4f204f20
  mov byte  [0xb800a], al
  jmp end

%include "./asm_funcs/check_cpuid.asm"
%include "./asm_funcs/check_long_mode.asm"
%include "./asm_funcs/longmode_prep.asm"
%include "./asm_funcs/longmode_gdt.asm"

[bits 64]
Realm64:
  cli
  mov ax, GDT.Data
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax
  mov edi, 0xB8000
  mov rax, 0x1F201F201F201F20
  mov ecx, 500
  rep stosq
  ; I would like to link rust here
  jmp $

times 510-($-$$) db 0
dw 0xaa55
