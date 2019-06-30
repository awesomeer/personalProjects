#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#include "stm32l432xx.h"
#include "I2C1.h"
#include "SH1106.h"

#define M_PI 3.14159265f;
#define SIZE 512

const int freTestp[] = {440, 1000, 2000, 10000, 18000};

uint16_t dIndex;
uint16_t ADCData[SIZE];



void SysTickInit(){
	RCC->AHB2ENR |= RCC_AHB2ENR_GPIOBEN;
	GPIOB->MODER &= ~GPIO_MODER_MODE3_Msk;
	GPIOB->MODER |= (0x01 << GPIO_MODER_MODE3_Pos);
	GPIOB->PUPDR &= ~GPIO_MODER_MODE3_Msk;
	GPIOB->PUPDR |= 0b10 << GPIO_MODER_MODE3_Pos;
	
	SysTick->CTRL = 0;
	SysTick->LOAD = (SystemCoreClock/40000)-1;
	SysTick->VAL = 0;
	SysTick->CTRL |= SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_TICKINT_Msk | SysTick_CTRL_ENABLE_Msk;
}

void ADCInit(){
	//Configure PA4 to be analog
	RCC->AHB2ENR |= 0x01; //Enable GPIOA clock
	GPIOA->MODER &= ~(GPIO_MODER_MODE4_Msk); //Clear Mode bits
	GPIOA->MODER |= 0x3 << GPIO_MODER_MODE4_Pos; //Set Mode bits to analog function
	
	//ADC Configuration
	RCC->CCIPR |= 0b11 << RCC_CCIPR_ADCSEL_Pos; //Select System clock
	RCC->AHB2ENR |= (1 << 13); //Enable ADC Clock
	ADC1->CR &= ~(ADC_CR_DEEPPWD_Msk); //Disable Deep Power down
	ADC1->CR |= ADC_CR_ADVREGEN_Msk; //Enable voltage Regulator
	for(int i = 0; i < 10000; i++) //wait for some time
		__nop();
	
	ADC1->DIFSEL &= 0x0; //set all channels to single ended
	ADC1->CFGR &= ~(ADC_CFGR_EXTEN_Msk); //Software Start
	ADC1->SQR1 |= (0x09 << ADC_SQR1_SQ1_Pos); //Channel 9 (1st)
	ADC1->SQR1 &= ~(ADC_SQR1_L_Msk); //one conversions
	ADC1->SMPR1 |= 0b111; //Maximum sample time
	
	ADC1->ISR |= ADC_ISR_ADRDY_Msk; //Clear ADC ready bit
	ADC1->CR |= ADC_CR_ADEN_Msk; //Enable ADC
	while(!(ADC1->ISR & ADC_ISR_ADRDY_Msk)); //Wait until ADC is ready
	
	//TEST with CONT=1
	ADC1->CFGR |= ADC_CFGR_CONT | ADC_CFGR_OVRMOD;
	ADC1->CR |= ADC_CR_ADSTART;
}

void clock32MHz(){
	PWR->CR1 |= PWR_CR1_DBP;
	RCC->CR |= RCC_CR_MSIRGSEL;
	RCC->CR = (RCC->CR & ~(0xF << 4)) | RCC_CR_MSIRANGE_10;
}

int DFT(uint16_t * in, int fs, int points, int ft){
	double ff = fs/points;
	double m = ft/ff;
  double real = 0, imag = 0;
	
	for(int i = 0; i < points; i++){
		double argu = (2.0 * 3.1415926 * (float) i * m) / points;
		double w = 0.5 - (0.5 * cos(2 * 3.1415926 * i / points));
		real += in[i] * cos(argu) * w;
		imag -= in[i] * sin(argu) * w;
	}

	return sqrt(pow(real,2) + pow(imag,2));
}

int main(){
	dIndex = 0;
	
	clock32MHz();
	SystemCoreClockUpdate();
	SH1106Init();
	ADCInit();
	SysTickInit();
	__enable_irq();
	
	
	
	while(1){
		while(dIndex < SIZE);
		int mag = DFT(ADCData, 40000, SIZE, 440)/512;
		dIndex = 0;
		SysTick->VAL = 0;
		SysTick->CTRL |= SysTick_CTRL_ENABLE_Msk | SysTick_CTRL_TICKINT_Msk;
	}
	return 0;
}


void SysTick_Handler(){
	GPIOB->ODR ^= 0x08;
	if(dIndex < SIZE){
		ADCData[dIndex] = ADC1->DR;
		dIndex++;
	}
	else{
		SysTick->CTRL &= ~(SysTick_CTRL_ENABLE_Msk | SysTick_CTRL_TICKINT_Msk);
		NVIC_ClearPendingIRQ(SysTick_IRQn);
	}
}
