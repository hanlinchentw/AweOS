; load_disk.asm
disk_load:
    pusha
    push dx
    
    mov ah, 0x02 ; ah <- 13h function. 0x02 = 'read'
    mov al, dh   ; al <- number of sectors to read
    mov cl, 0x02 ; cl <- sector (0x01 .. 0x11), 0x01 is our boot sector, 0x02 is the first available sector.

    mov ch, 0x00 ; cylinder
    ; dl <- drive number. Our caller sets it as a parameter and gets it from BIOS
    ; (0 = floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2)
    mov dh, 0x00 ; head number

    int 0x13
    jc disk_error

    pop dx
    cmp al, dh
    jne sectors_error

    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl

sectors_error:
    mov bx, SECTORS_ERROR
    call print

disk_loop:
    jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0
