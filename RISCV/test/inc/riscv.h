#pragma once

#ifndef _RISCV_H_
#define _RISCV_H_


#include <stdint.h>


#define LEDS    (*( (volatile uint32_t *) 0x00000004))


#define IPC     (*( (volatile uint64_t *) 0x00000020))
#define TICK    (*( (volatile uint64_t *) 0x00000028))

typedef struct
{
    uint32_t CTRL;
    uint32_t DATA;
} uart_t;

#define UART0   ((volatile  uart_t *) 0x00000030)


#endif