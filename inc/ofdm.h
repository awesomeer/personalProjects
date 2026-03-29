#pragma once

#include <stdint.h>
#define FFT_N 32
void ofdm_init(void);
void ofdm_transmit(uint8_t *data, uint32_t len);