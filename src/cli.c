
#include <FreeRTOS.h>
#include <FreeRTOS_CLI.h>

#include <task.h>

#include <string.h>

#include <usart2.h>
#include <cli.h>

#define GREETING "Welcome to the FreeRTOS CLI demo!\r\nType 'help' to view a list of registered commands.\r\n\r\n"
#define CONSOLE "$ "

static const uint8_t right_arrow[] = { 0x1B, 0x5B, 0x43 }; // ANSI escape code for right arrow

static BaseType_t cliTimeStatsCommand( char * pcWriteBuffer,
                         size_t xWriteBufferLen,
                         const char * pcCommandString )
{
    ( void ) pcCommandString;
    ( void ) xWriteBufferLen;

    vTaskGetRunTimeStats(pcWriteBuffer);
}

static const CLI_Command_Definition_t xTimeStats =
{
    "stats",
    "\r\nstats:\r\n Displays time statistics\r\n\r\n",
    cliTimeStatsCommand,
    0
};



static char cliInputBuffer[ configCOMMAND_INT_MAX_OUTPUT_SIZE ];
void cliTask(void *pvParameters)
{
    ( void ) pvParameters;

    // Get pointer to CLI output buffer and initialize with newline characters
    char * cliOutputBuffer = FreeRTOS_CLIGetOutputBuffer();
    cliOutputBuffer[0] = '\r';
    cliOutputBuffer[1] = '\n';

    // Add "stats" command to CLI
    static CLI_Definition_List_Item_t statsItem;
    FreeRTOS_CLIRegisterCommandStatic( &xTimeStats, &statsItem );

    usart2_write( ( uint8_t * ) GREETING, strlen( GREETING ) );

    for( ; ; )
    {
        // Print "$ " prompt
        usart2_write( ( uint8_t * ) CONSOLE, strlen( CONSOLE ) );

        // Get Command input from USART
        char inputChar;
        char * inputPtr = cliInputBuffer;
        for(;;) {
            while(usart2_read( ( uint8_t * ) &inputChar, 1, portMAX_DELAY ) == 0);
            if(inputChar == '\r' || inputChar == '\n') {
                *inputPtr = '\0'; // Null-terminate the input string
                break;
            } else if(inputChar == '\b') {
                // Handle backspace
                inputPtr--;
                if(inputPtr < cliInputBuffer) {
                    inputPtr = cliInputBuffer; // Prevent going before buffer start
                    usart2_write(right_arrow, sizeof(right_arrow)); // Move cursor back to prompt
                }
            } else {
                // Store character in input buffer
                *inputPtr++ = inputChar;
            }
        }
        
        // Process the command, we use Buffer[2] and onwards for the output to leave space for "\r\n" at the start
        while(FreeRTOS_CLIProcessCommand(cliInputBuffer, &cliOutputBuffer[2], configCOMMAND_INT_MAX_OUTPUT_SIZE-2) == pdTRUE);
        usart2_write( ( uint8_t * ) cliOutputBuffer, strlen( cliOutputBuffer ) );
    }
}
