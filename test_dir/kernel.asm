global _goose_start
section .text
_goose_start:
[bits 16]
KERNEL_OFFSET equ 0x1000
mov [BOOT_DRIVE], dl

mov bp, 0x9000
mov sp, bp

mov bx, KERNEL_OFFSET
mov dh, 15
mov dl, [BOOT_DRIVE]

push dx
mov ah, 0x02
mov al, dh
mov ch, 0x00
mov dh, 0x00
mov cl, 0x02
int 0x13

cli
lgdt [pm_gdt_descriptor]
mov eax, cr0
or eax, 0x1
mov cr0, eax
jmp PM_CODE_SEG: protected_mode_start

BOOT_DRIVE: db 0

pm_gdt_start:
  .gdt_null:
    dd 0x0
    dd 0x0
  .gdt_code:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10011010b
    db 11001111b
    db 0x0
  .gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0
  .gdt_end:
pm_gdt_descriptor:
  dw pm_gdt_start.gdt_end - pm_gdt_start - 1
  dd pm_gdt_start

PM_CODE_SEG equ pm_gdt_start.gdt_code - pm_gdt_start
PM_DATA_SEG equ pm_gdt_start.gdt_data - pm_gdt_start

[bits 32]
protected_mode_start:
mov ax, PM_DATA_SEG
mov ds, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax
mov ebp, 0x90000
mov esp, ebp
jmp $
[extern _start]
call _start
jmp $

times 510-($-$$) db 0
dw 0xaa55
