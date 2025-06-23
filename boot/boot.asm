; boot/boot.asm
[org 0x7c00]              ; BIOS loads boot sector to 0x7C00

start:
    cli                   ; Disable interrupts
    xor ax, ax
    mov ds, ax            ; Set data segment = 0x0000
    mov es, ax            ; Set extra segment = 0x0000
    mov ss, ax
    mov sp, 0x7c00        ; Set stack pointer (below bootloader 0x7c00)
 
    ;Print message using BIOS tty mode
    mov si, msg
.print_char:
    lodsb
    cmp al, 0
    mov ah, 0x0e
    int 0x10
    jmp .print_char

; Load kernal (1 sector, starting at LBA = 1 -> CHS = 0:0:2)
load_kernal:
    mov ah, 0x02          ; BIOS read sector
    mov al, 1             ; Read 1 sector
    mov ch, 0x00          ; Cylinder
    mov cl, 0x02          ; Sector 2 (CHS starts from 1)
    mov dh, 0x00          ; HEAD 0
    mov dl, 0x00          ; Drive 0 (floppy)
    mov bx, 0x1000        ; Load address (segment = 0)
    mov es, bx
    xor bx, bx
    int 0x13              ; BIOS interrupt disk read
    jc disk_error
   
    jmp 0x1000:0000       ; jump to loaded kernal

disk_error:
    mov si, err_msg
    call print_string
    jmp $

print_string:
    lodsb
    cmp al, 0
    je .done
    mov ah, 0x0e
    int 0x10
    jmp print_string
.done:
    ret

msg db "Booting AweOS...", 0
err_msg db "Disk read failed!", 0

; Padding + boot signature
times 510 - ($ - $$) db 0
dw 0xAA55


