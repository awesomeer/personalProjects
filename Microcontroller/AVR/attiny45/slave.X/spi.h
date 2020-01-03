/* 
 * File:   spi.h
 * Author: mithi
 *
 * Created on January 2, 2020, 3:39 PM
 */

#ifndef SPI_H
#define	SPI_H

#ifdef	__cplusplus
extern "C" {
#endif

    void spiInit();
    void sendData(unsigned char data);


#ifdef	__cplusplus
}
#endif

#endif	/* SPI_H */

