
#include "spi.h"
//PB1 DO
//PB2 SCK

void spiInit(){
    DDRB |= _BV(PB1) | _BV(PB2);
    PORTB &= ~_BV(PB1);
    USICR |= _BV(USIWM0);
}


void sendData(const unsigned char * data, char len){
    for(int i = 0; i < len; i++){
        USIDR = data[i];
        for(char j = 0; j < 8; j++){
            USICR = (1<<USIWM0)|(0<<USICS0)|(1<<USITC);
            USICR = (1<<USIWM0)|(0<<USICS0)|(1<<USITC)|(1<<USICLK);
        }
    }
}