/* 
 * File:   led.h
 * Author: mithi
 *
 * Created on December 31, 2019, 7:25 PM
 */

#ifndef LED_H
#define	LED_H

#include <stdint.h>
#define SIZE 31

#ifdef	__cplusplus
extern "C" {
#endif
    
    typedef struct {
        uint8_t brightness,blue,green,red;
    } led;
    
    led leds[SIZE];
    
    void ledInit();
    void changeColor();
    


#ifdef	__cplusplus
}
#endif

#endif	/* LED_H */

