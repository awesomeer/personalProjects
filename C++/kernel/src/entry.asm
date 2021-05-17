[bits 32]
[extern main]

    mov ah, 0x0f
    mov al, 'X'
    mov ebx, 0xb8000
    mov [ebx], ax
    
    call main

    jmp $