#include "../inc/uart.h"


#include <math.h>
void uart_send_char(uint8_t num){
    UART0->DATA = num;
    UART0->CTRL |= 1;
    while(UART0->CTRL & 2);
}

void uart_send_string(uint8_t * str, uint32_t len){
    for(uint32_t i = 0; i < len; i++)
        uart_send_char(str[i]);
}

void uart_send_stringn(uint8_t * str){

    while(*str){
        uart_send_char(*str++);
    }
}

void uart_send_uint32(uint32_t num){
    uint8_t buf[11];

    uint32_t len = 0;
    uint32_t temp = num;
    do{
        len++;
        temp /= 10;
    }while(temp);
    
    buf[len] = 0;
    do{
        len--;
        buf[len] = (num % 10) + 0x30;
        num /= 10;
    }while(!len);
    
    uart_send_stringn(buf);
}