#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#include "arm_math.h"
#include "arm_const_structs.h"
#include "stm32l432xx.h"
#include "SH1106.h"
#include "UART2.h"


#define M_PI 3.14159265f;
#define SIZE 128*4

uint16_t dIndex;
float32_t ADCData[SIZE * 2];
float32_t output[SIZE];
int8_t prevBar[128] = {0};

float32_t mult[128] = {0};


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
	
	ADC1->CR &= ~(ADC_CR_ADCALDIF);
	ADC1->CR |= ADC_CR_ADCAL;
	while(ADC1->CR & ADC_CR_ADCAL);
	
	ADC1->DIFSEL &= 0x0; //set all channels to single ended
	ADC1->CFGR &= ~(ADC_CFGR_EXTEN_Msk); //Software Start
	ADC1->SQR1 |= (0x09 << ADC_SQR1_SQ1_Pos); //Channel 9 (1st)
	ADC1->SQR1 &= ~(ADC_SQR1_L_Msk); //one conversions
	ADC1->SMPR1 |= 0b111; //Maximum sample time
	//ADC1->CFGR |= 0b10 << ADC_CFGR_RES_Pos; //Resolution (8 bit)
	ADC1->CFGR2 |= 0b111 << ADC_CFGR2_OVSR_Pos; //Over sample 64x
	ADC1->CFGR2 |= 0b1000 << ADC_CFGR2_OVSS_Pos; //Shift 8 bits right
	ADC1->CFGR2 |= ADC_CFGR2_ROVSE_Msk;
	
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

int main(){
	dIndex = 0;
	
	clock32MHz();
	SystemCoreClockUpdate();
	//Uart2Init();
	SH1106Init();
	ADCInit();
	SysTickInit();
	__enable_irq();
	
	mult[0] = 0;
	for(int i = 1; i < 128; i++)
		mult[i] = log10(i);
	
	while(1){
		while(dIndex < SIZE);
		clearBuffer();
		float32_t max = 0;
		uint32_t index = 0;
		
		
		arm_cfft_f32(&arm_cfft_sR_f32_len512, ADCData, 1, 1);
		arm_cmplx_mag_f32(ADCData, output, SIZE);
		for(int i = 0; i < SIZE/2; i++){
			output[i] = (output[2*i] + output[2*i+1])/2;
			output[i] *= mult[i];
		}
		output[0] = output[1] = output[2] = 0;
		arm_max_f32(output, SIZE, &max, &index);
		
		dIndex = 0;
		SysTick->VAL = 0;
		SysTick->CTRL |= SysTick_CTRL_ENABLE_Msk | SysTick_CTRL_TICKINT_Msk;
		
		for(int i = 0; i < 128; i++){
			//float32_t temp = (output[2*i] + output[2*i+1])/2;
			int bar = (output[i] * 64) / max;
			
			if(bar > prevBar[i]){
				prevBar[i] += bar >> 1;
				if(prevBar[i] > 63)
					prevBar[i] = 63;
			}
			else if(bar < prevBar[i]){
				prevBar[i] -= (prevBar[i] - bar) >> 1;
			}
			
			bar = prevBar[i];
			drawVLine(i, 64-bar, bar); 
		}

		refresh();

		
	}
	return 0;
}


void SysTick_Handler(){
	GPIOB->ODR ^= 0x08;
	if(dIndex < SIZE){
		ADCData[2 * dIndex] = ADC1->DR;
		ADCData[2 * dIndex + 1] = 0;
		dIndex++;
	}
	else{
		SysTick->CTRL &= ~(SysTick_CTRL_ENABLE_Msk | SysTick_CTRL_TICKINT_Msk);
		NVIC_ClearPendingIRQ(SysTick_IRQn);
	}
}
