#include "I2C1.h"
#include "stm32l432xx.h"

void I2C1Init(void){
	RCC->AHB2ENR |= RCC_AHB2ENR_GPIOBEN;
	GPIOB->MODER &= ~(GPIO_MODER_MODE6 | GPIO_MODER_MODE7);
	GPIOB->MODER |= (0x02 << GPIO_MODER_MODE6_Pos) | (0x02 << GPIO_MODER_MODE7_Pos);
	GPIOB->AFR[0] |= (0x04 << GPIO_AFRL_AFSEL6_Pos) | (0x04 << GPIO_AFRL_AFSEL7_Pos);
	
	GPIOB->OTYPER |= (1 << 6) | (1 << 7);
	GPIOB->PUPDR |= (0x01 << GPIO_PUPDR_PUPD6_Pos) | (0x01 << GPIO_PUPDR_PUPD7_Pos);
	
	RCC->CCIPR |= 0x01 << RCC_CCIPR_I2C1SEL_Pos; //Select Sysclock
	RCC->APB1ENR1 |= RCC_APB1ENR1_I2C1EN; //Enable clock
	
	I2C1->TIMINGR = 0x00707DBD;//0x30108EFF//0x00B06EA4//0x00707DBD
	I2C1->CR1 |= I2C_CR1_ANFOFF;
	I2C1->CR1 |= I2C_CR1_PE;
	I2C1->CR2 |= 0x3C << 1;
}


void sendData(uint8_t * data, int len){
	I2C1->CR2 &= ~(0xFF << I2C_CR2_NBYTES_Pos);
	I2C1->CR2 |= len << I2C_CR2_NBYTES_Pos;
	I2C1->CR2 |= I2C_CR2_AUTOEND;
	
	I2C1->CR2 |= I2C_CR2_START;
	while(!(I2C1->ISR & I2C_ISR_TC)){
		while(I2C1->ISR & I2C_ISR_TXIS){
			I2C1->TXDR = *data;
			data++;
		}
	}
}
