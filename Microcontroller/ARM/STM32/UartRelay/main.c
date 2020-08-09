#include <stm32l432xx.h>
#include "FIFO.h"

//PA2 Transmit to Host
//PA15 Recieve from Host
#define HUart USART2

//PA9 Transmit to Device
//PA10 Recieve from Device
#define DUart USART1

static FIFO HFifo, DFifo;

void setClock32MHz(void);
void GPIOAInit(void);
void HUartInit(void);
void DUartInit(void);

void USART2_IRQHandler(void){
	FifoPut(&HFifo, HUart->RDR);
	HUart->ICR = USART_ICR_ORECF;
}

void USART1_IRQHandler(void){
	FifoPut(&DFifo, DUart->RDR);
	DUart->ICR = USART_ICR_ORECF;
}

void setClock32MHz(void){
	PWR->CR1 |= PWR_CR1_DBP;
	RCC->CR |= RCC_CR_MSIRGSEL;
	RCC->CR = (RCC->CR & ~(0xFU << 4)) | RCC_CR_MSIRANGE_10;
}

int main(void){
	setClock32MHz();
	SystemCoreClockUpdate();
	FifoInit(&HFifo);
	FifoInit(&DFifo);
	GPIOAInit();
	HUartInit();
	DUartInit();
	
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
	}
	
	
	return 0;
}

void HUartInit(void){
	
	RCC->CCIPR |= 0x01 << RCC_CCIPR_USART2SEL_Pos;
	RCC->APB1ENR1 |= (1 << RCC_APB1ENR1_USART2EN_Pos); //Enable USART2 Clock
	
	HUart->CR1 |= (1 << USART_CR1_TE_Pos) | (1 << USART_CR1_RE_Pos);//Enable Transmit and Receieve Function
	HUart->BRR |= SystemCoreClock/115200;
	HUart->CR1 |= (1 << USART_CR1_UE_Pos);
	
	HUart->CR1 |= USART_CR1_RXNEIE;
	NVIC_EnableIRQ(USART2_IRQn);
	
}

void DUartInit(void){
	
	RCC->CCIPR |= 0x01 << RCC_CCIPR_USART1SEL_Pos;
	RCC->APB2ENR |= (1 << RCC_APB2ENR_USART1EN_Pos); //Enable USART1 Clock
	
	DUart->CR1 |= (1 << USART_CR1_TE_Pos) | (1 << USART_CR1_RE_Pos);//Enable Transmit and Receieve Function
	DUart->BRR = (unsigned int) SystemCoreClock/115200;
	DUart->CR1 |= (1 << USART_CR1_UE_Pos);
	
	DUart->CR1 |= USART_CR1_RXNEIE;
	NVIC_EnableIRQ(USART1_IRQn);
	
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
