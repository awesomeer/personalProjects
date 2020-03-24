/* 
 * File:   IR.h
 * Author: mithilesh
 *
 * Created on March 20, 2020, 9:19 PM
 */

#ifndef IR_H
#define	IR_H

#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdint.h>

#ifdef	__cplusplus
extern "C" {
#endif
    
    
    void IRInit();
    uint8_t getData(uint16_t * data);
    
    ISR(PCINT0_vect);
    ISR(TIMER1_OVF_vect);


#ifdef	__cplusplus
}
#endif

#endif	/* IR_H */

