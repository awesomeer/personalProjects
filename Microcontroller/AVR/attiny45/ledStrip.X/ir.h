/* 
 * File:   ir.h
 * Author: mithi
 *
 * Created on December 30, 2019, 12:53 PM
 */

#ifndef IR_H
#define	IR_H

#include <stdint.h>
#include <stdbool.h>

#define PIN 4

#ifdef	__cplusplus
extern "C" {
#endif
    
    unsigned long data,prev;
    bool buffer;
    
    void enableIR();
    bool newData();
    
    uint32_t getBoth();
    uint16_t getAddress();
    uint16_t getData();
    


#ifdef	__cplusplus
}
#endif

#endif	/* IR_H */

