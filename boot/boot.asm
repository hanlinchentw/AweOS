; boot/boot.asm
[org 0x7c00]              ; BIOS loads boot sector to 0x7C00


msg db "Booting AweOS...", 0
err_msg db "Disk read failed!", 0

; Padding + boot signature
times 510 - ($ - $$) db 0
dw 0xAA55


