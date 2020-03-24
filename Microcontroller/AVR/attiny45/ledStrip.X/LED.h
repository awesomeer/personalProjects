/* 
 * File:   LED.h
 * Author: mithilesh
 *
 * Created on March 22, 2020, 4:09 PM
 */

#ifndef LED_H
#define	LED_H

#include <stdint.h>
#include <string.h>
#include <avr/interrupt.h>
#include "SPI.h"

#ifdef	__cplusplus
extern "C" {
#endif

    typedef struct led{
        uint8_t bright, blue, green, red;
    } led_t;
    
    void LEDInit();
    
    void changeLed(uint16_t code);


#ifdef	__cplusplus
}
#endif

#endif	/* LED_H */

