;this is because our labels don't account for correct location, this is our proper offset
[org 0x7c00]



times 510-($-$$) db 0
dw 0xaa55
