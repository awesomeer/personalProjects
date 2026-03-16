
#include <stm32l4xx.h>

int main(void){
    while(1){
        __NOP();
    }
}

void _exit(int status) {
    while(1){
        __NOP();
    }
}