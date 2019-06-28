#ifndef I2C1_H_
#define I2C1_H_

#include <stdint.h>

void I2C1Init(void);

void sendData(uint8_t * data, int len);

#endif
