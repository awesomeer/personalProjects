

#include <stdio.h>
#include <stdint.h>


#include "../inc/riscv.h"
#include "../inc/uart.h"


void main(void){

    uart_send_uint32(1234);
    uart_send_char('\n');
    while(1);

    // uint32_t prime = 1;
    // while(1){

    //     con:
    //     prime++;
    //     for(uint32_t i = 0; i <= prime/2; i++){
    //         if(prime % i == 0)
    //             goto con;
    //     }

    //     LEDS = prime;
    // }

}