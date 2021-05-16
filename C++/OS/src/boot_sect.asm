[org 0x7c00]

    jmp main

    %include "inc/string.asm"

    


main:
    mov bx, HELLO
    call puts

    mov bx, 0x7c00
    mov cx, bx
    add cx, 512
main_loop:
    cmp bx, cx
    jge infinite_loop

    mov al, [bx]
    inc bx
    call print_hex_byte

    jmp main_loop     

infinite_loop:
    jmp $


HELLO:
    db 'Hello Stupid, Bye', 10, 13, 0

    times 510-($-$$) db 0
    dw 0xaa55