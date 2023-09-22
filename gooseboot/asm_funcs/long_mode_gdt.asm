long_mode_set_up_page_tables:
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
