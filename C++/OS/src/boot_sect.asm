

KERNEL_OFFSET equ 0x1000

    mov [BOOT_DRIVE], dl
    mov bp, 0x9000
    mov sp, bp

    mov bx, HELLO16
    call print_string


    call load_kernel
    call pm_switch

    jmp $

%include "inc/gdt.asm"
%include "inc/string.asm"
%include "inc/disk.asm"


[bits 16]

load_kernel:
    mov bx, 0x0
    mov es, bx
    mov bx, KERNEL_OFFSET

    mov dh, 15
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]

BEGIN_PM:
    xor eax, eax
    mov ebx, HELLO32
    call puts

    call KERNEL_OFFSET
    hlt
    jmp $


BOOT_DRIVE:
    db 0

HELLO16:
    db 'Hello World 16',0

HELLO32:
    db 'Hello World 32',0

times 510-($-$$) db 0
dw 0xaa55