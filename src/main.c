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

int main( void )
{

    /* Turn on HSI16 clock */
    RCC->CR |= RCC_CR_HSION;
    while (!(RCC->CR & RCC_CR_HSIRDY));
    /* Select HSI16 as system clock source */
    RCC->CFGR |= RCC_CFGR_SW_HSI;

    SystemCoreClockUpdate();

    LD3_init();
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
            LD3_toggle();
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
