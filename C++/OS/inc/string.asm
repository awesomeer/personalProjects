puts:
    mov ah, 0x0e
puts_loop:
    mov al, [bx]
    cmp al, 0
    je puts_return
    int 0x10
    add bx, 1
    jmp puts_loop
puts_return:
    ret


print_hex_nibble:

    push ax

    mov ah, 0x0e

    cmp al, 10
    jl print_hex_num

    ; Nibble is a letter
    add al, 55
    int 0x10

    pop ax
    ret

    ;Nibble is a number
print_hex_num:
    add al, 48
    int 0x10

    pop ax
    ret





print_hex_byte:

    push ax
    push bx

    ; Output MSB
    mov bl, al
    shr al, 4
    and al, 0xf
    call print_hex_nibble

    ; Output LSB
    mov al, bl
    and al, 0x0f
    call print_hex_nibble

    pop bx
    pop ax

    ret