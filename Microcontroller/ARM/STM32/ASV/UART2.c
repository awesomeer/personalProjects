#include "stm32l432xx.h"
#include "UART2.h"
#include "FIFO.h"

FIFO TX;

void Uart2Init(void){
	FifoInit(&TX);
	
	RCC->AHB2ENR |= RCC_AHB2ENR_GPIOAEN; //Enable GPIOA clock
	GPIOA->MODER &= ~(GPIO_MODER_MODE3 | GPIO_MODER_MODE2); //Clear GPIOA 2 & 3 Mode
	GPIOA->MODER |= (0b10 << GPIO_MODER_MODE3_Pos) | (0b10 << GPIO_MODER_MODE2_Pos); //Configure to Alternate Function
	GPIOA->AFR[0] |= (0x7 << GPIO_AFRL_AFSEL3_Pos) | (0x7 << GPIO_AFRL_AFSEL2_Pos); //Configure Alternate Function

	RCC->CCIPR |= 0b01 << RCC_CCIPR_USART2SEL_Pos; //Select System Clock
	RCC->APB1ENR1 |= RCC_APB1ENR1_USART2EN; //Enable USART2 Clock
	
	USART2->BRR = SystemCoreClock/115200;
	USART2->CR1 |= USART_CR1_TE; //Set Transmit Enable
	USART2->CR1 |= USART_CR1_UE; //Enable UART
	
	NVIC_EnableIRQ(USART2_IRQn);
	NVIC_SetPriority(USART2_IRQn, 0);
}

void UartTransmit(uint8_t * data, uint32_t len){
	for(int i = 0; i < len; i++){
		while(FifoPut(&TX, data[i])){
			USART2->CR1 |= USART_CR1_TXEIE;
		}
	}
	USART2->CR1 |= USART_CR1_TXEIE;
}

void USART2_IRQHandler(){
	uint32_t send;
	if(FifoGet(&TX, &send)){
		//USART2->ICR |= USART_ICR_TCCF;
		USART2->CR1 &= ~(USART_CR1_TXEIE);
	}
	else
		USART2->TDR = send;
}
