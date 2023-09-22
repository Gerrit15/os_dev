[bits 16]
;switch to protected mode

switch_to_pm:
  cli
  lgdt [gdt_descriptor]
  ; flipping the first bit of a cpu control register, 
  ; cr0 (we can't assign directly)
  mov eax, cr0
  or eax, 0x1
  mov cr0, eax
  ; we force cpu to flush internal registers with a far jump
  jmp CODE_SEG: start_protected_mode

[bits 32]
start_protected_mode:
  mov ax, DATA_SEG  ; now in PM, old segments are meaningless
  mov ds, ax        ; so we point our segment registers to the data segment in GDT
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov ebp, 0x90000  ; new stack! :D
  mov esp, ebp

  call BEGIN_PM
