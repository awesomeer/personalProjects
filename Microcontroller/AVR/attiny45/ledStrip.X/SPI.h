/* 
 * File:   SPI.h
 * Author: mithilesh
 *
 * Created on March 22, 2020, 4:14 PM
 */

#ifndef SPI_H
#define	SPI_H

#include <stdint.h>
#include <avr/io.h>

#ifdef	__cplusplus
extern "C" {
#endif

    void SPIInit();
    void SPIoutArray(uint8_t * data, uint8_t size);
    void SPIout(uint8_t data);


#ifdef	__cplusplus
}
#endif

#endif	/* SPI_H */

