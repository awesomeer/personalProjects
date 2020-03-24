#include "SPI.h"

#define SCK PB2
#define DI PB0
#define D0 PB1

void SPIInit(){
    DDRB |= (1 << SCK) | (1 << D0);
    USICR |= 1 << USIWM0;
}
void SPIoutArray(uint8_t * data, uint8_t size){
    for(int i = 0; i < size; i++){
        USIDR = data[i];
        for(int j = 0; j < 8; j++){
            USICR |= (1 << USICLK) | (1 << USITC);
            USICR |= (1 << USITC);
        }
    }
}
void SPIout(uint8_t data){
    USIDR = data;
    for(int j = 0; j < 8; j++){
        USICR |= (1 << USICLK) | (1 << USITC);
        USICR |= (1 << USITC);
    }
}
