#include "ir.h"
#include <avr/io.h>
#include <avr/interrupt.h>


#define F_CPU 8000000UL
#include <util/delay.h>
void enableIR(){
    DDRB |= _BV(PIN3);
    PCMSK |= _BV(PIN);
    GIMSK |= _BV(PCIE);
    SREG |= _BV(7);
    buffer = false;
}

bool newData(){
    
    if(buffer){
        buffer = false;
        return true;
    }
    
    return false;
}

uint32_t getBoth(){
    return prev;
}
uint16_t getAddress(){
    return prev & 0xFFFF;
}
uint16_t getData(){
    return prev >> 16;
}

#define OFF !(PINB & _BV(PIN))
#define ON PINB & _BV(PIN)

unsigned int ticks = 0;
extern void delay();
ISR(PCINT0_vect){
    PORTB |= _BV(PIN3);
    
    if(ON){
        goto exit;
    }
    
    data = 0;
    
    while(OFF);
    
    ticks = 0;
    while(ON){
        ticks++;
        if(ticks == 256*8)
            goto exit;
    }
    
    for(int i = 0; i < 32; i++){
        data >>= 1;
        
        while(OFF);
        _delay_ms(0.570);//delay();
        if(ON){
            data |= 0x80000000;
        }
        ticks = 0;
        while(ON){
            ticks++;
            if(ticks == 256*8)
                goto exit;
        }
    }
    _delay_ms(0.563);//delay();
    if(((unsigned int) (data & 0xFFFF)) == 0xFF00){
        prev = data;
        buffer = true;
    }
    exit:
    asm("nop");
    GIFR |= _BV(PCIF);
    PORTB &= ~_BV(PIN3);
}