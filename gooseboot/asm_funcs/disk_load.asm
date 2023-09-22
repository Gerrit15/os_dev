disk_load:
  push dx           ; stores how many sectors we want read for later

  mov ah, 0x02      ; BIOS Read Sector function
  mov al, dh        ; read a dh number of sectors
  mov ch, 0x00      ; select cylinder 0
  mov dh, 0x00      ; select head 0
  mov cl, 0x02      ; start reading from second sector (after boot)

  int 0x13          ; friendly neightborhood bios interrupt

  jc disk_error

  pop dx
  cmp dh, al        ; if al (sectors read) != dh (sectors expected)
  jne disk_error    ; something's gone wrong
  ret

disk_error:
  mov bx, DISK_ERROR_MSG
  call print_string_rm
  jmp $

DISK_ERROR_MSG db "Disk read error!", 0
