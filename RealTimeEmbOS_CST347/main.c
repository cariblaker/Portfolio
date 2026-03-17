/*************************************************************
* Author: Cari Blaker
* Filename: main.c
* Date Created: 02/24/2024
* Assignment: CST347 Lab 5
* Overview: This program assigns three strings to three
* buttons on the expansion board, using interrupt handling for
* the buttons and the computer keyboard to display messages
* typed or sent by buttons. keyboard numbers correspond with
* led's to toggle them on/off.
* Modifications:
* 3/15 - added button task & global message
**************************************************************/
//system includes
#include <asf.h>
#include <stdint.h>
#include <stdbool.h>
#include <FreeRTOS.h>
#include <task.h>
#include <timers.h>
#include <queue.h>
#include <semphr.h>

//my includes
#include "myTasks.h"
#include "OITExpansionBoard.h"
#include "OITExpansionBoardDefines.h"
#include "ledDriver.h"
#include "buttonDriver.h"
#include "message.h"
#include "uartdrv.h"

//defines
#if(BOARD == SAM4E_XPLAINED_PRO)
	//used to place the heap
	#define mainHEAP_START		_estack
	#define mainRAM_LENGTH		0x00020000	/* 128 KB of internal SRAM. */
	#define mainRAM_START		0x20000000	/* at 0x20000000 */
	/* The SAM4E Xplained board has 2 banks of external SRAM, each one 512 KB. */
	#define mainEXTERNAL_SRAM_SIZE		(512ul * 1024ul)
#else	#error Define memory regions here.
#endif /* SAM4E_XPLAINED_PRO */

//Function Prototypes
static void prvMiscInitialisation(void);
static void prvInitialiseHeap(void);

//used to initialize heap:
extern char _estack;

//global Q handles
QueueHandle_t LedQ;
QueueHandle_t TXQ;
QueueHandle_t RXQ;

//create the task handles
TaskHandle_t toggle_LED = NULL;
TaskHandle_t button_task = NULL;

int main ( void ) {
	// Initialize The Board
	prvMiscInitialisation();

	//create the queues
	LedQ = xQueueCreate(5, 1);								//Led Queue, depth of 5 messages, 1 byte
	TXQ = xQueueCreate(20, 50);								//UART transmit Queue, depth of 20 messages, size 50 bytes
	RXQ = xQueueCreate(20, 1);								//UART receive Queue, depth of 20 messages, size 1 byte
	
					
	//create the heartbeat task
	xTaskCreate(toggleLED, "heartbeat", configMINIMAL_STACK_SIZE, 0, 1, NULL);
	//create the LED task
	xTaskCreate(ledTask, "LED task", configMINIMAL_STACK_SIZE, NULL, 2, &toggle_LED);
	//create the UART tasks
	xTaskCreate(TXTask, "UART TX", configMINIMAL_STACK_SIZE, NULL, 3, NULL);
	xTaskCreate(RXTask, "UART RX", configMINIMAL_STACK_SIZE, NULL, 4, NULL);
	//create the button task
	xTaskCreate(ButtonTask, "Button Task", configMINIMAL_STACK_SIZE, NULL, 4, &button_task);

	// Start The Scheduler
	vTaskStartScheduler();

	for ( ;; );
}


/**********************************************************************
* Purpose: This function initializes the board
*
************************************************************************/
static void prvMiscInitialisation( void )
{
	/* Initialize the SAM system */
	sysclk_init();
	board_init();
	prvInitialiseHeap();
	pmc_enable_periph_clk(ID_PIOA);
	pmc_enable_periph_clk(ID_PIOB);
	
	//Initialize the expansion board
	OITExpansionBoardInit();
	
	//Initialize LEDs & Buttons
	initializeLEDDriver();
	initializeButtonDriver();
	
	//Initialize UART
	initUART(EDBG_UART);
}

/**********************************************************************
* Purpose: This function initializes the heap
*
************************************************************************/
static void prvInitialiseHeap( )
{
	uint32_t ulHeapSize;
	uint8_t *pucHeapStart, *pucHeapEnd;
	pucHeapStart = ( uint8_t * ) ( ( ( ( uint32_t ) &mainHEAP_START ) + 7 ) &
	~0x07ul );
	pucHeapEnd = ( uint8_t * ) ( mainRAM_START + mainRAM_LENGTH );
	ulHeapSize = ( uint32_t ) ( ( uint32_t ) pucHeapEnd - ( uint32_t )
	&mainHEAP_START );
	ulHeapSize &= ~0x07ul;
	ulHeapSize -= 1024;
	HeapRegion_t xHeapRegions[] = {
		{ ( unsigned char *) pucHeapStart, ulHeapSize },
		{ ( unsigned char *) SRAM_BASE_ADDRESS, mainEXTERNAL_SRAM_SIZE },
		{ ( unsigned char *) SRAM_BASE_ADDRESS_2ND, mainEXTERNAL_SRAM_SIZE },
		{ NULL, 0 }
	};
	vPortDefineHeapRegions( xHeapRegions );
}


void vAssertCalled( const char *pcFile, uint32_t ulLine )
{
	volatile uint32_t ulBlockVariable = 1;//0UL;
	/* Setting ulBlockVariable to a non-zero value in the debugger will allow
	this function to be exited. */
	taskDISABLE_INTERRUPTS();
	{
		while( ulBlockVariable == 0UL )
		{
			__asm volatile( "NOP" );
		}
	}
	taskENABLE_INTERRUPTS();
}


void vApplicationMallocFailedHook( void )
{
	/* Called if a call to pvPortMalloc() fails because there is insufficient
	free memory available in the FreeRTOS heap. pvPortMalloc() is called
	internally by FreeRTOS API functions that create tasks, queues, software
	timers, and semaphores. The size of the FreeRTOS heap is set by the
	configTOTAL_HEAP_SIZE configuration constant in FreeRTOSConfig.h. */
	vAssertCalled( __FILE__, __LINE__ );
}


void vApplicationStackOverflowHook( TaskHandle_t pxTask, char *pcTaskName )
{
	( void ) pcTaskName;
	( void ) pxTask;
	/* Run time stack overflow checking is performed if
	configCHECK_FOR_STACK_OVERFLOW is defined to 1 or 2. This hook
	function is called if a stack overflow is detected. */
	taskDISABLE_INTERRUPTS();
	for( ;; );
}

