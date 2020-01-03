#include "spi.h"
#include <avr/io.h>

void spiInit(){
    DDRB |= _BV(PB1) | _BV(PB2);
    PORTB &= ~(_BV(PB1) | _BV(PB2));
    USICR |= _BV(USIWM0);
}

void sendData(unsigned char data){
    USIDR = data;
    for(int i = 0; i < 8; i++){
        USICR = (1<<USIWM0)|(0<<USICS0)|(1<<USITC);
        USICR = (1<<USIWM0)|(0<<USICS0)|(1<<USITC)|(1<<USICLK);
    }
}
