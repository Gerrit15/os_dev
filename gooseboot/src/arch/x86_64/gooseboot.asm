global start
section .text
; fortunately grub puts us in protected mode automatically
[bits 32]
start:
  mov esp, stack_top                ; stack init

  call check_multiboot
  call check_cpuid
  call check_long_mode

  call set_up_page_tables
  call enable_paging

  mov dword [0xb8000], 0x2f4b2f4f   ; print "ok"
  jmp end

end:
  jmp $

error:
  mov dword [0xb8000], 0x4f524f45
  mov dword [0xb8004], 0x4f3a4f52
  mov dword [0xb8008], 0x4f204f20
  mov byte  [0xb800a], al
  jmp end

check_multiboot:
  cmp eax, 0x36d76289
  jne .no_multiboot
  ret
.no_multiboot:
  mov al, "0"
  jmp error

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

check_long_mode:
  mov eax, 0x80000000
  cpuid
  cmp eax, 0x80000001
  jb .no_long_mode

  mov eax, 0x80000001
  cpuid
  test edx, 1 << 29
  jz .no_long_mode
  ret
.no_long_mode:
  mov al, "2"
  jmp error

set_up_page_tables:
  ; map the first p4 entry to the p3 table
  ; the .bss section is already initialized to 0 by grub, so p4_table is valid
  mov eax, p3_table
  or eax, 0b11  ; present + writable
  mov [p4_table], eax

  ; map the first p3 entry to the p2 table
  mov eax, p2_table
  or eax, 0b11  ; present + writable
  mov [p3_table], eax
  ; map each p2 entry to a huge 2MiB page
  mov ecx, 0                        ; nice little counter
  .map_p2_table:
    ; map ecx-th P2 entry to a huge page that starts at address 2MiB*ecx
    mov eax, 0x200000               ; 2MiB
    mul ecx                         ; start address of ecx-th page
    or eax, 0b10000011              ; present + writable + huge
    mov [p2_table + ecx * 8], eax   ; map ecx-th entry
    inc ecx                         ; inc counter
    cmp ecx, 512                    ; if counter == 512, the whole table is mapped
    jne .map_p2_table               ; else mape the next entry
  ret

enable_paging:
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

; block start symbol
section .bss
align 4096
p4_table:
  resb 4096         ; this does not actually db, but it reserves
p3_table:
  resb 4096
p2_table:
  resb 4096

stack_bottom:
  resb 64 ; reserve byte
stack_top:
