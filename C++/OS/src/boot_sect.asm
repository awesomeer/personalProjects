[org 0x7c00]


    mov bp, 0x9000
    mov sp, bp

    call pm_switch
    jmp $

%include "inc/gdt.asm"
%include "inc/string.asm"

[bits 32]

BEGIN_PM:
    xor eax, eax
    mov ebx, HELLO
    call puts_32

    jmp $


HELLO:
    db 'Hello World',0

times 510-($-$$) db 0
dw 0xaa55