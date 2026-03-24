#include <FreeRTOS.h>
#include <task.h>
#include <semphr.h>

#include <stm32l432xx.h>

#include <analog.h>


#define FFT_N 64

static void initDMA(void)
{

    RCC->AHB1ENR |= RCC_AHB1ENR_DMA1EN;					    // Enable DMA1 Clock

    // DAC DMA Configuration
    DMA1_Channel3->CCR = (0b01 << DMA_CCR_MSIZE_Pos)    | 	// 16-bit Memory Size
                        (0b10 << DMA_CCR_PSIZE_Pos)     | 	// 32-bit Peripheral Size
                        DMA_CCR_MINC				    | 	// Increment Memory Address
                        //DMA_CCR_CIRC                    | 	// Circular DMA
                        DMA_CCR_DIR                     |	// Memory to Peripheral Direction
                        DMA_CCR_TCIE;						// Enable Transfer Complete Interrupt

    DMA1_Channel3->CPAR = (uint32_t) &DAC1->DHR12R1;		// Destination Peripheral Address DAC1 DHR12R1

    // ADC DMA Configuration
    DMA1_Channel1->CCR = (0b01 << DMA_CCR_MSIZE_Pos)    | 	// 16-bit Memory Size
                        (0b10 << DMA_CCR_PSIZE_Pos)     | 	// 32-bit Peripheral Size
                        DMA_CCR_MINC                    |   // Increment Memory Address
                        //DMA_CCR_CIRC                    | 	// Circular DMA
                        //DMA_CCR_DIR;					 	// Memory to Peripheral Direction
                        DMA_CCR_TCIE;						// Enable Transfer Complete Interrupt

    DMA1_Channel1->CPAR = (uint32_t) &ADC1->DR;			    // Source Peripheral Address ADC1 Data Register

    DMA1_CSELR->CSELR = (0b0000 << DMA_CSELR_C1S_Pos) |     // Select ADC1 Request for Channel 1
                        (0b0110 << DMA_CSELR_C3S_Pos);	    // Select TIM6 Request for Channel 3

    NVIC_SetPriority(DMA1_Channel1_IRQn, configMAX_SYSCALL_INTERRUPT_PRIORITY >> __NVIC_PRIO_BITS);
    NVIC_SetPriority(DMA1_Channel3_IRQn, configMAX_SYSCALL_INTERRUPT_PRIORITY >> __NVIC_PRIO_BITS);    
    NVIC_EnableIRQ(DMA1_Channel1_IRQn);
    NVIC_EnableIRQ(DMA1_Channel3_IRQn);
}

static void initTIM6(void)
{
    RCC->APB1ENR1 |= RCC_APB1ENR1_TIM6EN;       // Enable TIM6 Clock

    TIM6->PSC = SystemCoreClock/1000 - 1;       // 1000 Hz Timer Clock
    TIM6->ARR = 9;                              // 100 Hz Update Event

    TIM6->CR2 = 0b010 << TIM_CR2_MMS_Pos;       // Update Event as TRGO
    TIM6->DIER = TIM_DIER_UDE;                  // Enable DMA Request
}

static void initDAC(void)
{
    RCC->APB1ENR1 |= RCC_APB1ENR1_DAC1EN;           // Enable DAC1 Clock

    DAC1->MCR = (0b011 << DAC_MCR_MODE1_Pos);       // Connect both DAC1 Channels to external pin with buffer enabled

    DAC1->CR = DAC_CR_EN1;                          // Enable DAC1 Channel 1
}

static void initADC(void)
{

    RCC->AHB2ENR |= RCC_AHB2ENR_ADCEN;					// Enable ADC Clock
    ADC1_COMMON->CCR = 0b01 << ADC_CCR_CKMODE_Pos;

    ADC1->CR &= ~ADC_CR_DEEPPWD;						// Disable DEEPPWD
    ADC1->CR |= ADC_CR_ADVREGEN;						// Enable ADC VReg

    vTaskDelay(pdMS_TO_TICKS(1000));                    // Wait >= 20us for Vreg

    ADC1->CR |= ADC_CR_ADCAL;							// Start Single-ended Calibration
    while(ADC1->CR & ADC_CR_ADCAL);						// Wait until Calibration is done

    ADC1->CR |= ADC_CR_ADCALDIF;						// Enable Differential Calibration
    ADC1->CR |= ADC_CR_ADCAL;							// Start Calibration
    while(ADC1->CR & ADC_CR_ADCAL);						// Wait until Calibration is done

    ADC1->CR |= ADC_CR_ADEN;							// Enable ADC
    while(!(ADC1->ISR & ADC_ISR_ADRDY));				// Wait until ADC is ready
    ADC1->ISR = ADC_ISR_ADRDY;							// Clear ADRDY bit


    ADC1_COMMON->CCR |= ADC_CCR_VREFEN;					// Enable Vrefint channel

    ADC1->SMPR2 |= ADC_SMPR2_SMP17;						// Max Sampling Time
    ADC1->SQR1 = 0 << ADC_SQR1_L_Pos |					// 1 conversion
                17 << ADC_SQR1_SQ1_Pos;					// Channel 17 ADC1


    ADC1->CFGR |= ADC_CFGR_DMAEN                |       // Enable DMA
                (0b01 << ADC_CFGR_EXTEN_Pos)    |		// External Rising Edge
                (13 << ADC_CFGR_EXTSEL_Pos);			// TIM6_TRGO External input
}

 SemaphoreHandle_t xAnalogSemaphore = NULL;
 StaticSemaphore_t xAnalogSemaphoreBuffer;

void analog_init(void)
{
    initDMA();
    initTIM6();
    initDAC();
    initADC();

    xAnalogSemaphore = xSemaphoreCreateBinaryStatic( &xAnalogSemaphoreBuffer );
}


static uint16_t dac_buff[FFT_N];
static uint16_t adc_buff[FFT_N];
void analog_runifft(void)
{
    RCC->AHB2ENR |= RCC_AHB2ENR_GPIOAEN;

    for(int i = 0; i < FFT_N; i++)
    {
        dac_buff[i] = (uint16_t) ( ( i*0xFFF / (FFT_N-1) ) );
    }

    DMA1_Channel3->CNDTR = FFT_N;                   // 64 Transfers

    DMA1_Channel3->CMAR = (uint32_t) dac_buff;      // DAC Buffer Storage

    DMA1_Channel1->CNDTR = FFT_N;                   // 64 Transfers

    DMA1_Channel1->CMAR = (uint32_t) adc_buff;      // ADC Buffer Storage

    DMA1_Channel1->CCR |= DMA_CCR_EN;               // Enable DMA1 Channel 1
    DMA1_Channel3->CCR |= DMA_CCR_EN;               // Enable DMA1 Channel 3

    ADC1->CR |= ADC_CR_ADSTART;                     // Start ADC

    TIM6->CNT = 0;                                  // Reset Counter
    TIM6->CR1 |= TIM_CR1_CEN;                       // Start TIM6

    xSemaphoreTake(xAnalogSemaphore, portMAX_DELAY);// Wait for ADC conversion to complete
    TIM6->CR1 &= ~TIM_CR1_CEN;                      // Stop TIM6
}


void DMA1_Channel1_IRQHandler(void)
{
    if(DMA1->ISR & DMA_ISR_TCIF1)
    {
        DMA1->IFCR = DMA_IFCR_CTCIF1    |           // Clear Transfer Complete Flag
                    DMA_IFCR_CHTIF1     |           // Clear Half Transfer Flag
                    DMA_IFCR_CTEIF1     |           // Clear Transfer Error Flag
                    DMA_IFCR_CGIF1;					// Clear Global Interrupt Flag
        DMA1_Channel1->CCR &= ~DMA_CCR_EN;		    // Disable DMA1 Channel 1
        xSemaphoreGiveFromISR( xAnalogSemaphore, NULL );
    }
}

void DMA1_Channel3_IRQHandler(void)
{
    if(DMA1->ISR & DMA_ISR_TCIF3)
    {
        DMA1->IFCR = DMA_IFCR_CTCIF3    |           // Clear Transfer Complete Flag
                    DMA_IFCR_CHTIF3     |           // Clear Half Transfer Flag
                    DMA_IFCR_CTEIF3     |           // Clear Transfer Error Flag
                    DMA_IFCR_CGIF3;					// Clear Global Interrupt Flag
        DMA1_Channel3->CCR &= ~DMA_CCR_EN;		    // Disable DMA1 Channel 3
    }
}