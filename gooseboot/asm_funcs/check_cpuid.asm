check_cpuid:
  pushfd
  pop eax           ; copy flags into eax

  mov ecx, eax      ; copy flags to ecx for later
  xor eax, 1 << 21  ; flip the id bit

  push eax
  popfd             ; copy eax to flags
  pushfd
  pop eax           ; copy flags back, hopfully with a flipped bit

  push ecx
  popfd             ; restore flags

  cmp eax, ecx      ; compare to see if the flags got flipped
  je .no_cpuid
  ret
.no_cpuid:
  mov al, "1"
  jmp error
