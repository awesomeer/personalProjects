/* 
 * File:   IR.c
 * Author: mithilesh
 *
 * Created on March 20, 2020, 9:19 PM
 */

#include "IR.h"
#define F_CPU 8000000UL

#define low0 300
#define high0 900
#define low1 1200
#define high1 2000
#define low9 
#define PIN (PINB & _BV(PB3))

uint32_t necCode;
uint8_t valid;
enum state_t {IDLE, MS9, MS45, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9, B10, B11, B12, B13, B14, B15, B16, B17,
                B18, B19, B20, B21, B22, B23, B24, B25, B26, B27, B28, B29, B30, B31, END};

enum state_t state;

uint32_t count;//, prevCount;
static uint32_t time, diff, prev;

void IRInit(){
    necCode = 0;
    valid = 0;
    state = IDLE;
    count = 0;
    time = diff = prev = 0;
    
    SREG &= ~_BV(7); //Disable Interrupts
    
    //Configure Interrupt on PB3
    GIMSK |= _BV(PCIE);
    PCMSK |= _BV(PCINT3);
    
    //Configure timer for 1us/tick
    TIMSK |= _BV(TOIE1); //Enable Timer Overflow Interrupt
    TCNT1 = 0; //Set Timer count to 0
    TCCR1 |= 0b100; //Set prescaler to divide by 8
    
    SREG |= _BV(7); //Enable Interrupts
}

uint8_t getData(uint16_t * data){
    if(valid){
        *data = (uint16_t) (necCode >> 16);
        valid = 0;
        return 0;
    }
    else{
        return -1;
    }
}

ISR(PCINT0_vect){   
    time = (count*256) + TCNT1;
    diff = time - prev;
    PORTB ^= _BV(PB4);
    if(state >= IDLE && state <= MS45){
        switch(state){
            case IDLE:{
                state = PIN ? IDLE : MS9;
                prev = count = 0;
                goto exit;
            }
            case MS9:{
                state = diff >= 8550 && diff <= 9450 && PIN ? MS45 : IDLE;
                goto set;
                
            }
            case MS45:{
                state = diff >= 4000 && diff <= 5000 && !PIN ? B0 : IDLE;
                goto set;
            }
            default:{
                state = IDLE;
                goto exit;
            }
        }
    }
    
    if(state == END){
        valid = 1;
        state = IDLE;
        prev = count = 0;
        goto exit;
    }
    
    
    if(!PIN){state++;
    //necCode = necCode << 1;
    necCode = necCode >> 1;
        if(diff >= low1 && diff <= high1)
            //necCode |= 0x01;
            necCode |= 0x80000000;
        else if(!(diff >= low0 && diff <= high0))
            state = IDLE;
    }

set:    
    prev = time;
exit:
    GIFR = _BV(PCIF);
}

ISR(TIMER1_OVF_vect){
    count++;
}


