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