#include "ir.h"
#include <avr/io.h>
#include <avr/interrupt.h>


#define F_CPU 1000000/8UL

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
    buffer = false;
    return prev;
}
uint16_t getAddress(){
    buffer = false;
    return prev & 0xFFFF;
}
uint16_t getData(){
    buffer = false;
    return prev >> 16;
}

#define OFF !(PINB & _BV(PIN))
#define ON PINB & _BV(PIN)

extern void delay();
//extern void inter();
//
//ISR(PCINT0_vect){
//    inter();
//}

unsigned char ticks = 0;
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
        if(!ticks)
            goto exit;
    }
    
    for(int i = 0; i < 32; i++){
        data >>= 1;
        
        while(OFF);
        delay();//_delay_us(563);
        if(ON){
            data |= 0x80000000;
        }
        ticks = 0;
        while(ON){
            ticks++;
            if(!ticks)
                goto exit;
        }
    }
   delay();// _delay_us(563);
    prev = data;
    buffer = true;
    exit:
    asm("nop");
    GIFR |= _BV(PCIF);
    PORTB &= ~_BV(PIN3);
}