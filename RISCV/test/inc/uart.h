#pragma once

#ifndef _UART_H_
#define _UART_H_



#include "riscv.h"



void uart_send_char(uint8_t num);
void uart_send_string(uint8_t * str, uint32_t len);
void uart_send_stringn(uint8_t * str);
void uart_send_uint32(uint32_t num);


#endif