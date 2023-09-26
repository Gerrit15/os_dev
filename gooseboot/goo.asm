;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; stripped down version of my normal protected mode jump.
; (as such, apologies for the lack of comments)
; when you uncomment [org 0x7c00] it works, but 
; without it, qemu freaks out on the long jump
; because of linkers, I haven't been able to use the [org 7c000], 
; and as a result qemu is freaking out on the jump
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;[org 0x7c00]
global _start
section .text
_start:
mov bp, 0x9000
mov sp, bp

call switch_to_pm
jmp end

gdt_start:
  gdt_null:
    dd 0x0
    dd 0x0
  gdt_code:
    dw 0xffff   
    dw 0x0      
    db 0x0      
    db 10011010b
    db 11001111b
    db 0x0      
  gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0
  gdt_end: 
gdt_descriptor:
  dw gdt_end - gdt_start - 1    
  dd gdt_start                  
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

[bits 16]
switch_to_pm:
  cli
  lgdt [gdt_descriptor]
  mov eax, cr0
  or eax, 0x1
  mov cr0, eax
  jmp CODE_SEG: start_protected_mode
[bits 32]
start_protected_mode:
  mov ax, DATA_SEG  
  mov ds, ax        
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ebp, 0x90000  
  mov esp, ebp

BEGIN_PM:
jmp $

end:
  jmp $
times 510-($-$$) db 0
dw 0xaa55
