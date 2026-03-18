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

/*-----------------------------------------------------------*/

static void exampleTask( void * parameters ) __attribute__( ( noreturn ) );

/*-----------------------------------------------------------*/

uint8_t uart_rx[128];
uint8_t buffer[128];
static void exampleTask( void * parameters )
{
    /* Unused parameters. */
    ( void ) parameters;

    for( ; ; )
    {
        /* Example Task Code */
        TickType_t tick_count = xTaskGetTickCount();
        uint32_t len = snprintf ( ( char * ) buffer, sizeof(buffer), "Hello from FreeRTOS! Tick count: %d\n\r",  (uint32_t)tick_count);
        usart2_write( buffer, len );

        vTaskGetRunTimeStats( ( char * ) buffer );
        usart2_write( buffer, strlen(buffer) );

        len = usart2_read(uart_rx, sizeof(uart_rx)-1, 0 );
        if (len > 0) {
            uart_rx[len] = '\0'; // Null-terminate the received string
            len = snprintf ( ( char * ) buffer, sizeof(buffer),"Received: %d bytes: %s\n\r", len, uart_rx );
            usart2_write( buffer, len );
        }

        vTaskDelay( pdMS_TO_TICKS( 1000 ) ); /* delay 1 second */
    }
}
/*-----------------------------------------------------------*/

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
    static StaticTask_t exampleTaskTCB;
    static StackType_t exampleTaskStack[ configMINIMAL_STACK_SIZE ];

    //( void ) printf( "Example FreeRTOS Project\n" );

    ( void ) xTaskCreateStatic( &exampleTask,
                                "example",
                                configMINIMAL_STACK_SIZE,
                                NULL,
                                configMAX_PRIORITIES - 1U,
                                &( exampleTaskStack[ 0 ] ),
                                &( exampleTaskTCB ) );

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
    }

#endif /* #if ( configCHECK_FOR_STACK_OVERFLOW > 0 ) */
/*-----------------------------------------------------------*/
