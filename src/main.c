/* FreeRTOS includes. */
#include <FreeRTOS.h>
#include <task.h>
#include <queue.h>
#include <timers.h>
#include <semphr.h>

/* Standard includes. */
#include <stdio.h>
#include <string.h>

#include <stm32l432xx.h>
#include <led.h>
#include <usart2.h>
#include <cli.h>
#include <hub75.h>

int main( void )
{

    // Change Flash latency for 80MHz
    FLASH->ACR |= FLASH_ACR_LATENCY_4WS; // 4 wait states for 80MHz

    // Use PLL to get 80MHz system clock
    RCC->CR |= RCC_CR_HSION; // Enable HSI16
    while (!(RCC->CR & RCC_CR_HSIRDY)); // Wait for HSI16 to be ready
    RCC->PLLCFGR = (0 << RCC_PLLCFGR_PLLM_Pos) | // PLLM = 1
                   (10 << RCC_PLLCFGR_PLLN_Pos) | // PLLN = 10
                   (0 << RCC_PLLCFGR_PLLP_Pos) | // PLLP = 7 (not used)
                   (0 << RCC_PLLCFGR_PLLQ_Pos) | // PLLQ = 2 (not used)
                   (0 << RCC_PLLCFGR_PLLR_Pos) | // PLLR = 2
                   RCC_PLLCFGR_PLLREN | // Enable PLLR output
                   RCC_PLLCFGR_PLLSRC_HSI; // HSI16 as PLL source
    RCC->CR |= RCC_CR_PLLON; // Enable PLL
    while (!(RCC->CR & RCC_CR_PLLRDY)); // Wait for PLL to be ready
    RCC->CFGR |= RCC_CFGR_SW_PLL; // Select PLL as system clock source
    while ((RCC->CFGR & RCC_CFGR_SWS) != RCC_CFGR_SWS_PLL); // Wait for PLL to be used as system clock source

    SystemCoreClockUpdate();

    LD3_init();
    hub75_draw();
    usart2_init();
    static StaticTask_t cliTaskTCB;
    static StackType_t cliTaskStack[ 256 ];

    //( void ) printf( "Example FreeRTOS Project\n" );

    ( void ) xTaskCreateStatic( &cliTask,
                                "CLI_Task",
                                256,
                                NULL,
                                configMAX_PRIORITIES - 1U,
                                &( cliTaskStack[ 0 ] ),
                                &( cliTaskTCB ) );

    /* Start the scheduler. */
    vTaskStartScheduler();

    for( ; ; )
    {
        /* Should not reach here. */
    }

    return 0;
}


#if ( configUSE_IDLE_HOOK > 0 )

    void vApplicationIdleHook( void )
    {
        static TickType_t xTickCount = 0;
        if( xTaskGetTickCount() - xTickCount >= configTICK_RATE_HZ )
        {
            xTickCount = xTaskGetTickCount();
            //LD3_toggle();
        }
    }

#endif /* configUSE_IDLE_HOOK */

/*-----------------------------------------------------------*/

#if ( configCHECK_FOR_STACK_OVERFLOW > 0 )

    void vApplicationStackOverflowHook( TaskHandle_t xTask,
                                        char * pcTaskName )
    {
        /* Check pcTaskName for the name of the offending task,
         * or pxCurrentTCB if pcTaskName has itself been corrupted. */
        ( void ) xTask;
        ( void ) pcTaskName;
        while(1);
    }

#endif /* #if ( configCHECK_FOR_STACK_OVERFLOW > 0 ) */
/*-----------------------------------------------------------*/
