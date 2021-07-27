

ENTRY(_start)


SECTIONS
{
    . = 0x00000;
    .text : { *(.text)}

    . = 0x10000;
    .rodata : { *(.rodata .srodata) *(.srodata.*) }
    
    . = 0x20000;
    .data : { *(.data) *(.sdata) }
    .bss  : { *(.bss)  *(.sbss) }
}

