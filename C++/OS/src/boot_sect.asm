[org 0x7c00]

    jmp main

    %include "inc/string.asm"

    


main:
    mov bx, HELLO
    call puts
    jmp $


HELLO:
    db 'Hello Stupid',0x0A, 0x0D, 'Bye', 0

    times 510-($-$$) db 0
    dw 0xaa55