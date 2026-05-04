
#include <stdint.h>
#include <stdbool.h>

#include <stm32l432xx.h>

#include "../tools/image.h"

#define HEIGHT 64
#define WIDTH 64


typedef struct {
    bool r1 : 1;
    bool g1 : 1;
    bool rsvd : 1; // Reserved PA2 is UART TX pin
    bool b1 : 1;
    bool r2 : 1;
    bool g2 : 1;
    bool b2 : 1;
    bool clk : 1;
} hub75_pixel_t;

hub75_pixel_t pixels[8][HEIGHT/2][WIDTH];
hub75_pixel_t pix_dma_buff[2*WIDTH] __attribute__((section(".sram2")));

typedef struct {
    uint8_t r;
    uint8_t g;
    uint8_t b;
} pixel_t;

void hub75_setImage(pixel_t * image){

    for(int b = 0; b < 8; b++){
        for(int r = 0; r < HEIGHT/2; r++){
            for(int c = 0; c < WIDTH; c++){
                hub75_pixel_t pix = {0};

                uint32_t top_idx = (r * WIDTH) + c;
                pix.r1 = image[top_idx].r & (1 << b);
                pix.g1 = image[top_idx].g & (1 << b);
                pix.b1 = image[top_idx].b & (1 << b);

                uint32_t bot_idx = ((r + HEIGHT/2) * WIDTH) + c;
                pix.r2 = image[bot_idx].r & (1 << b);
                pix.g2 = image[bot_idx].g & (1 << b);
                pix.b2 = image[bot_idx].b & (1 << b);
                
                pix.clk = 0; // CLK is handled in the timer interrupt
                pix.rsvd = 0;

                //pix.lat = 0; // Latch is handled in the timer interrupt
                //pix.oe = 0;  // Output Enable is handled in the timer interrupt

                pixels[b][r][c] = pix;
            }
        }
    }
}

/* HUB75 State Machine */

// 128 64 32 16 8 4 2 1

uint8_t current_row = (HEIGHT/2) - 1;
uint8_t current_bit = 7;
uint8_t skip = 1;
void TIM6_IRQHandler(void)
{
    GPIOB->ODR |= GPIO_ODR_OD3;
    if(--skip == 0){
        // TODO Do Latch and then start DMA
        GPIOA->ODR = (GPIOA->ODR & ~0x1F00) | (current_row << 8); // Set ROW pins PA8-PA12
        GPIOB->ODR |= GPIO_ODR_OD0; // Set LAT high
#if 1
        current_row++;
        if(current_row >= HEIGHT/2){
            current_row = 0;
            current_bit++;
            if(current_bit >= 8){
                current_bit = 0;
            }  
        }
#endif
        skip = 1 << current_bit;
        
        hub75_pixel_t * curr_row_pixels = pixels[current_bit][current_row];
        for(int i = 0; i < WIDTH; i++){
            pix_dma_buff[2*i] = curr_row_pixels[i];
            pix_dma_buff[2*i + 1] = curr_row_pixels[i];
            pix_dma_buff[2*i + 1].clk = 1;
        }

        DMA1_Channel1->CCR &= ~DMA_CCR_EN; // Disable DMA channel
        DMA1_Channel1->CNDTR = 2*WIDTH; // Number of data items to transfer        
        DMA1_Channel1->CCR |= DMA_CCR_MEM2MEM; // Start Transfer
        DMA1_Channel1->CCR |= DMA_CCR_EN; // Enable DMA channel

        GPIOB->ODR &= ~GPIO_ODR_OD0; // Set LAT Low
    }


    /* Check if the update interrupt flag is set. */
    if (TIM6->SR & TIM_SR_UIF)
    {
        /* Clear the update interrupt flag. */
        TIM6->SR &= ~TIM_SR_UIF;
    }
    GPIOB->ODR &= ~GPIO_ODR_OD3;
}




void hub75_draw(void){

    for(int i = 0; i < WIDTH; i++){
        hub75_pixel_t pix = {0};
        pix.r1 = i & (1 << 0);
        pix.g1 = i & (1 << 1);
        pix.b1 = i & (1 << 2);
        pix.r2 = i & (1 << 3);
        pix.g2 = i & (1 << 4);
        pix.b2 = i & (1 << 5);
        pix.clk = 0; // Latch on the last pixel of the row
        pix.rsvd = 0;
        //pix.lat = i==WIDTH-1 ? 1 : 0; // Latch on the last pixel of the row

        pixels[0][0][i] = pix;
    }

    hub75_setImage((pixel_t *)raw_image);

    /*
        * GPIOA Pinout:
        * PA0 - R1
        * PA1 - G1
        * PA2 - UART TX (Reserved)
        * PA3 - B1
        * PA4 - R2
        * PA5 - G2
        * PA6 - B2
        * PA7 - CLK
        * PA8-PA12 - ROW select (5 bits for 32 rows)
    */
    // Enable GPIOA clock
    RCC->AHB2ENR |= RCC_AHB2ENR_GPIOAEN;
    // Configure PA0 PA1 PA3-PA12 as output with no pull-up/pull-down and high speed
    GPIOA->MODER &= ~0x03FFFFCF; // Clear mode bits for PA0, PA1, PA3-PA12
    GPIOA->MODER |= 0x01555545;  // Set PA0, PA1, PA3-PA12 as output
    GPIOA->PUPDR &= ~0x03FFFFCF; // Clear pull-up/pull-down bits for PA0, PA1, PA3-PA12
    GPIOA->OSPEEDR &= ~0x03FFFFCF; // Clear speed bits for PA0-PA7
    GPIOA->OSPEEDR |= 0x03FFFFCF;  // Set PA0-PA7 to high speed
    GPIOA->ODR &= ~0x1FFB; // Clear output data bits for PA0-PA7


    RCC->AHB1ENR |= RCC_AHB1ENR_DMA1EN;	// Enable DMA1 Clock
    // Setup DMA to send pixels[current_bit][current_row] to the GPIO pins
    DMA1_Channel1->CCR = (0b00 << DMA_CCR_MSIZE_Pos)    | 	// 8-bit Memory Size
                        (0b00 << DMA_CCR_PSIZE_Pos)     | 	// 8-bit Peripheral Size
                        DMA_CCR_MINC				    | 	// Increment Memory Address
                        DMA_CCR_DIR;                     	// Memory to Peripheral Direction
    DMA1_Channel1->CNDTR = 2*WIDTH; // Number of data items to transfer
    //DMA1_Channel1->CMAR = (uint32_t) &pixels[current_bit][current_row][0]; // Memory address
    DMA1_Channel1->CMAR = (uint32_t) &pix_dma_buff[0]; // Memory address
    DMA1_Channel1->CPAR = (uint32_t) &GPIOA->ODR; // Peripheral address

    /* 
        * GPIOB Pinout:
        * PB0 - LAT
        * PB1 - OE
    */
    GPIOB->MODER &= ~(GPIO_MODER_MODE0_Msk
                    | GPIO_MODER_MODE1_Msk);
    GPIOB->MODER |= (GPIO_MODER_MODE0_0
                    | GPIO_MODER_MODE1_0);
    
    GPIOB->PUPDR &= ~(GPIO_PUPDR_PUPD0_Msk
                    | GPIO_PUPDR_PUPD1_Msk);
    GPIOB->ODR &= ~(GPIO_ODR_OD0
                    | GPIO_ODR_OD1);

    /* Enable the TIM6 clock. */
    RCC->APB1ENR1 |= RCC_APB1ENR1_TIM6EN;

    /* Set the prescaler so the timer counts at 1 MHz. */
    TIM6->PSC = SystemCoreClock/1000000 - 1;

    /* Set the auto-reload value to 999, so the timer overflows every 1 ms. */
    TIM6->ARR = 99;

    /* Enable the update interrupt. */
    TIM6->DIER |= TIM_DIER_UIE;

    /* Enable the timer. */
    TIM6->CR1 |= TIM_CR1_CEN;
    NVIC_EnableIRQ(TIM6_IRQn);
    NVIC_SetPriority(TIM6_IRQn, 0);


}