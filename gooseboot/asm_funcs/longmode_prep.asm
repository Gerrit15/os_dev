longmode_prep:
  mov eax, cr0
  and eax, 01111111111111111111111111111111b
  mov cr0, eax

  ; clears the tables, tbh not sure how it works
  mov edi, 0x1000
  mov cr3, edi
  xor eax, eax
  mov ecx, 4096
  rep stosd
  mov edi, cr3

  ; actaully set locations of table
  mov DWORD [edi], 0x2003
  add edi, 0x1000
  mov DWORD [edi], 0x3003
  add edi, 0x1000
  mov DWORD [edi], 0x4003
  add edi, 0x1000

  mov ebx, 0x00000003
  mov ecx, 512

  .SetEntry:
    mov DWORD [edi], ebx
    add ebx, 0x1000
    add edi, 8
    loop .SetEntry
  mov eax, cr4
  or eax, 1 << 5
  mov cr4, eax

  mov ecx, 0xC0000080
  rdmsr
  or eax, 1 << 8
  wrmsr
  mov eax, cr0
  or eax, 1 << 31 | 1 << 0
  mov cr0, eax
  ret
