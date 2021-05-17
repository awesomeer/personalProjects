; Function to load in kernal

[bits 16]

disk_load:

    push dx

    mov ah, 0x02        ; BIOS read sector function
    mov al, dh          ; read DH sectors
    mov ch, 0x00        ; Select cylinder 0
    mov dh, 0x00        ; Select head 0
    mov cl, 0x02        ; Start reading after boot sector on disk

    int 0x13            ; BIOS interrupt

    jc disk_error

    pop dx
    cmp dh, al
    jne disk_error
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

DISK_ERROR_MSG:
    db 'Error reading disk',0