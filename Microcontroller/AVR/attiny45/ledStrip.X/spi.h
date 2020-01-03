/* 
 * File:   spi.h
 * Author: mithi
 *
 * Created on December 19, 2019, 7:44 PM
 */

#ifndef SPI_H
#define	SPI_H
#include <avr/io.h>
#ifdef	__cplusplus
extern "C" {
#endif

    void spiInit();
    void sendData(const unsigned char * data, char len);


#ifdef	__cplusplus
}
#endif

#endif	/* SPI_H */

