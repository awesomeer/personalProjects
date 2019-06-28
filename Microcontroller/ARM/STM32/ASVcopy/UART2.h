#ifndef _UART2_H_
#define _UART2_H_

#include <stdint.h>

void Uart2Init(void);
void UartTransmit(uint8_t * data, uint32_t len);



#endif
