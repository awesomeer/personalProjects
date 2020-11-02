#include <stm32l432xx.h>
#include <stdio.h>
#include <stdlib.h>
#include "FIFO.h"

//PA2 Transmit to Host
//PA15 Recieve from Host
#define HUart USART2
#define HSpeed 115200

//PA9 Transmit to Device
//PA10 Recieve from Device
#define DUart USART1
#define DSpeed 115200


#define DMA 0


void setClock32MHz(void);
void GPIOAInit(void);
void HUartInit(void);
void DUartInit(void);

#if DMA == 0

static FIFO HFifo, DFifo;

void USART2_IRQHandler(void){
	FifoPut(&HFifo, HUart->RDR);
	HUart->ICR = USART_ICR_ORECF;
}

void USART1_IRQHandler(void){
	FifoPut(&DFifo, DUart->RDR);
	DUart->ICR = USART_ICR_ORECF;
}

#endif

//volatile static unsigned int idle = 0;
//void SysTick_Handler(void){
//	static unsigned int prev = 0;
//	char buffer[32];
//	unsigned int len = (unsigned int) sprintf(buffer, "%d\n", idle-prev);
//	for(unsigned int i = 0; i < len; i++){
//		#if DMA == 0
//		FifoPut(&DFifo, buffer[i]);
//		#else
// 		while(!(HUart->ISR & USART_ISR_TXE) || !(HUart->ISR & USART_ISR_TC));
//		HUart->TDR = buffer[i];
//		#endif
//	}
//	
//	prev = idle;
//	SysTick->VAL = 0;
//}

void setClock32MHz(void){
	PWR->CR1 |= PWR_CR1_DBP;
	RCC->CR |= RCC_CR_MSIRGSEL;
	RCC->CR = (RCC->CR & ~(0xFU << 4)) | RCC_CR_MSIRANGE_10;
}

int main(void){
	setClock32MHz();
	SystemCoreClockUpdate();

	GPIOAInit();
	HUartInit();
	DUartInit();
	
	
	#if DMA
	
	RCC->AHB1ENR |= RCC_AHB1ENR_DMA1EN;
	
	DMA1_Channel6->CPAR = (uint32_t) &(HUart->RDR);
	DMA1_Channel6->CMAR = (uint32_t) &(DUart->TDR);
	DMA1_Channel6->CNDTR = 1;
	DMA1_CSELR->CSELR |= (0x2 << DMA_CSELR_C6S_Pos);
	DMA1_Channel6->CCR = (0x1 << DMA_CCR_PL_Pos) | (1 << DMA_CCR_CIRC_Pos) | (1 << DMA_CCR_EN_Pos);
	
	
	DMA1_Channel5->CPAR = (uint32_t) &(DUart->RDR);
	DMA1_Channel5->CMAR = (uint32_t) &(HUart->TDR);
	DMA1_Channel5->CNDTR = 1;
	DMA1_CSELR->CSELR |= (0x2 << DMA_CSELR_C5S_Pos);
	DMA1_Channel5->CCR = (0x1 << DMA_CCR_PL_Pos) | (1 << DMA_CCR_CIRC_Pos) | (1 << DMA_CCR_EN_Pos);
	
	SysTick->LOAD = SystemCoreClock/10;
	SysTick->VAL = 0;
	SysTick->CTRL = 7;
	
	while(1){
		idle++;
	}
	
	#else
	
	FifoInit(&HFifo);
	FifoInit(&DFifo);
	
	//SysTick->LOAD = SystemCoreClock/10;
	//SysTick->VAL = 0;
	//SysTick->CTRL = 7;
	
	unsigned int HtoD, DtoH;
	while(1){
		
		//Device to Host
		if((HUart->ISR & USART_ISR_TXE) && (HUart->ISR & USART_ISR_TC)){
			if(!FifoGet(&DFifo, &DtoH)){
				HUart->TDR = (unsigned char) DtoH;
			}
		}
		
		//Host to Device
		if((DUart->ISR & USART_ISR_TXE) && (DUart->ISR & USART_ISR_TC)){
			if(!FifoGet(&HFifo, &HtoD)){
				DUart->TDR = (unsigned char) HtoD;
			}
		}
		
		//idle++;
	}
	
	#endif
	
	return 0;
}

void HUartInit(void){
	
	RCC->CCIPR |= 0x01 << RCC_CCIPR_USART2SEL_Pos;
	RCC->APB1ENR1 |= (1 << RCC_APB1ENR1_USART2EN_Pos); //Enable USART2 Clock
	
	HUart->CR1 |= (1 << USART_CR1_TE_Pos) | (1 << USART_CR1_RE_Pos);//Enable Transmit and Receieve Function
	HUart->BRR |= SystemCoreClock/115200;
	HUart->CR1 |= (1 << USART_CR1_UE_Pos);
	
	#if DMA
		HUart->CR3 |= USART_CR3_DMAR;
	#else
		HUart->CR1 |= USART_CR1_RXNEIE;
		NVIC_EnableIRQ(USART2_IRQn);
	#endif
	
}

void DUartInit(void){
	
	RCC->CCIPR |= 0x01 << RCC_CCIPR_USART1SEL_Pos;
	RCC->APB2ENR |= (1 << RCC_APB2ENR_USART1EN_Pos); //Enable USART1 Clock
	
	DUart->CR1 |= (1 << USART_CR1_TE_Pos) | (1 << USART_CR1_RE_Pos);//Enable Transmit and Receieve Function
	DUart->BRR = (unsigned int) SystemCoreClock/DSpeed;
	DUart->CR1 |= (1 << USART_CR1_UE_Pos);
	
	#if DMA
		DUart->CR3 |= USART_CR3_DMAR;
	#else
		DUart->CR1 |= USART_CR1_RXNEIE;
		NVIC_EnableIRQ(USART1_IRQn);
	#endif
	
}

void GPIOAInit(void){
	
	RCC->AHB2ENR |= RCC_AHB2ENR_GPIOAEN; //Enable GPIOA
	GPIOA->MODER &= ~(GPIO_MODER_MODE15 | GPIO_MODER_MODE10 | GPIO_MODER_MODE9 | GPIO_MODER_MODE2);//Clear Modes
	GPIOA->MODER |= (0x02U << GPIO_MODER_MODE15_Pos) | (0x02U << GPIO_MODER_MODE10_Pos) | (0x02U << GPIO_MODER_MODE9_Pos) | (0x02U << GPIO_MODER_MODE2_Pos);//Set Mode to Alternate Function
	
	GPIOA->PUPDR &= ~(GPIO_PUPDR_PUPD15 | GPIO_PUPDR_PUPD10 | GPIO_PUPDR_PUPD9 | GPIO_PUPDR_PUPD2);//No resistors
	GPIOA->PUPDR |= (0x02U << GPIO_PUPDR_PUPD15_Pos) | (0x02U << GPIO_PUPDR_PUPD10_Pos) | (0x02U << GPIO_PUPDR_PUPD9_Pos) | (0x02U << GPIO_PUPDR_PUPD2_Pos);//PullDown resistors
	
	GPIOA->AFR[0] |= 0x07 << GPIO_AFRL_AFSEL2_Pos; //PA2 Alternate Function USART2 TX
	GPIOA->AFR[1] |= (0x03 << GPIO_AFRH_AFSEL15_Pos) | (0x07 << GPIO_AFRH_AFSEL10_Pos) | (0x07 << GPIO_AFRH_AFSEL9_Pos); //ALternate Function
	
}
