[bits 16] 

print_string:
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



[bits 32]

VIDEO_ADDRESS equ 0xB8000
WHITE_ON_BLACK equ 0x0f

puts:

    pusha
    mov edx, VIDEO_ADDRESS
    mov ah, WHITE_ON_BLACK

puts_32loop:
    mov al, [ebx]

    cmp al, 0
    je done

    mov [edx], ax
    add ebx, 1
    add edx, 2

    jmp puts_32loop

done:
    popa
    ret
