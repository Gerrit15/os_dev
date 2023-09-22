long_mode_enable_paging:
  mov eax, p4_table     ; load p4 into cr3 reigster for cpu
  mov cr3, eax

  mov eax, cr4          ; enable PAE flag in cr4 (physical address extension)
  or eax, 1 << 5
  mov cr4, eax

  mov ecx, 0xC0000080   ; set long mode bit in EFER MSR (model specific register)
  rdmsr
  or eax, 1 << 8
  wrmsr

  mov eax, cr0          ; enable paging in the cr0 register
  or eax, 1 << 31
  mov cr0, eax

  ret
