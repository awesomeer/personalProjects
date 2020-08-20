/*
 * File:   main.c
 * Author: mithi_000
 *
 * Created on August 17, 2020, 9:43 PM
 */


#include <avr/io.h>
#include <avr/interrupt.h>

unsigned int count;
unsigned int adc;

void gpioInit(void);
void timerInit(void);
void adcInit(void);

int main(void) {
    count = 0;
    adc = 0;
    
    gpioInit();
    adcInit();
    timerInit();
    sei();
    
    while(1){
        
    }
    
    return 0;
}

void gpioInit(void){
    DDRB = 0x0F;
    PORTB = 0x00;
}

void adcInit(void){
    
    //ADC init
    ADMUX |= 0b0010;
    ADCSRA |= _BV(ADEN) | _BV(ADATE) | _BV(ADIE);
    ADCSRB |= 0b100;
    DIDR0 |= _BV(ADC2D);
    
    //ADC Trigger Init (Timer 0 Overflow)
    TCCR0B |= 0b101;   
}

ISR(ADC_vect){
    TIFR = _BV(TOV0);
    
    adc = ADCW >> 2;
    if(adc == 0)
        adc = 1;
}

void timerInit(void){
    TCNT1 = 0;
    OCR1A = 0xFF;
    OCR1C = 0xFF; 
    TIMSK |= _BV(TOIE1);
    TCCR1 |= _BV(PWM1A) | 0b0100;
}

ISR(TIM1_OVF_vect){
    if(count == 0)
        PORTB = ((PORTB & 0xF) + 1) % 16;
    
    count = (count + 1) % adc;
}