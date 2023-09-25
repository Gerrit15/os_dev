;[org 0x7c00]
mov bp, 0x9000
mov sp, bp
call switch_to_pm

jmp $
; just load beyond the bootloader here, stupid

%include "./asm_funcs/gdt.asm"
%include "./asm_funcs/switch_to_pm.asm"
%include "./asm_funcs/disk_load.asm"
%include "./asm_funcs/print_string_rm.asm"

load_kernal:
  mov bx, 0x1000

[bits 32]
BEGIN_PM:
; continue here, if you wish
call check_cpuid
call check_long_mode

; thus begins long mode entry (hopefully)
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
;  mov edi, 0xB8000
;  mov rax, 0x1F201F201F201F20
  mov ecx, 500
  rep stosq
  [extern main]
  call main
  jmp $

times 510-($-$$) db 0
dw 0xaa55

