/*************************************************************
* Author: Cari Blaker
* Filename: myTasks.c
* Date Created: 01/28/2024
* Modifications:  02/24 - consolidated three control tasks into
* one main control task, added UART messages to all tasks
* 3/6 - beginnning of lab5, removal of unnecessary tasks and
* additions of necessary tasks
* 3/12 - added delay to ledTASK
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
#include <stdio.h>
#include <string.h>
#include <stdio.h>

#include "message.h"
#include "myTasks.h"
#include "FreeRTOS.h"
#include "task.h"
#include "ledDriver.h"
#include "buttonDriver.h"
#include "OITExpansionBoardDefines.h"
#include "uartdrv.h"

extern int BUTTON_STATE;
char UART_MSG[50];

	
/**********************************************************************
* Purpose: Blocks until the LED Queue contains a message. toggles the 
* corresponding LED based on that message.
************************************************************************/
void ledTask(void * pvParameters){
	uint8_t LedNum;
	TickType_t xDelay = 10 / portTICK_PERIOD_MS;
	for( ;; ){
		if (uxQueueMessagesWaiting(LedQ) > 0){		//if the queue has a message, then increase/decrease xDelay based on message.
			//toggles named LED, just once!
			if (xQueueReceive(LedQ, &LedNum, 0) == pdPASS){
				setLED(LedNum, !readLED(LedNum));
			}	// end receive queue if
		} //end message waiting if
		vTaskDelay(xDelay);
	}// end for ( ;; ) 
} // end ledTask() function
 

void TXTask(void *pvParameters) {
	TickType_t xDelay = 10 / portTICK_PERIOD_MS;    //create delay variable of 10 ms
	
	for (;;) {
		if (uxQueueMessagesWaiting(TXQ) > 0) {
			if (xQueueReceive(TXQ, UART_MSG, portMAX_DELAY) == pdPASS) {
				// Find the size of the received message
				size_t msgSize = strlen(UART_MSG);                                 // Variable to hold the size of the received message
				
				// Transmit the message
				UARTPutStr(EDBG_UART, UART_MSG, msgSize);
			}
		}
		vTaskDelay(xDelay);
	}
}

 /**********************************************************************
 * Purpose: Detects a message from the UART's RX Queue, sends it to the 
 * UART re function
 ************************************************************************/
void RXTask(void *pvParameters) {
    TickType_t xDelay = 10 / portTICK_PERIOD_MS;   //create delay variable of 10 ms
	uint8_t one = 1;
	uint8_t two = 2;
	uint8_t three = 3;
    for (;;) {
        if (uxQueueMessagesWaiting(RXQ) > 0) {
            if (xQueueReceive(RXQ, UART_MSG, portMAX_DELAY) == pdPASS) {
                // Process the character
                switch(UART_MSG[0]) {
                    case '1':
                        xQueueSendToBack(LedQ, &one, portMAX_DELAY);
						strcpy(UART_MSG, "1");
                        break;
                    case '2':
						strcpy(UART_MSG, "2");
                        xQueueSendToBack(LedQ, &two, portMAX_DELAY);
                        break;
                    case '3':
						strcpy(UART_MSG, "3");
                        xQueueSendToBack(LedQ, &three, portMAX_DELAY);
                        break;
                    case 'u':
                        // Display your name on its own line
						strcpy(UART_MSG, "\r\nCari Blaker\r\n");
                        UARTPutStr(EDBG_UART, UART_MSG, strlen(UART_MSG));
                        break;
                }
				// Send character to TX task for echo
				xQueueSendToBack(TXQ, UART_MSG, portMAX_DELAY);
            }
        }
        vTaskDelay(xDelay);
    }
}


 /**********************************************************************
 * Purpose: processes interrupt when a button is pressed. Blocks on
 * notification of the interrupt until the notification is received from
 * the ISR. 
 ************************************************************************/
void ButtonTask(void *pvParameters) {
	for(;;){
		ulTaskNotifyTake(pdTRUE, portMAX_DELAY);
		switch(BUTTON_STATE){
		case 1:
			strcpy(UART_MSG, "\r\nHello FreeRTOS World\r\n");
			xQueueSendToBack(TXQ, UART_MSG, portMAX_DELAY);
			break;
		case 2:
			strcpy(UART_MSG, "\r\nCST347 - RTOS\r\n");
			xQueueSendToBack(TXQ, UART_MSG, portMAX_DELAY);
			break;
		case 3:
			strcpy(UART_MSG, "\r\nLab 05 - Interrupts in FreeRTOS\r\n");
			xQueueSendToBack(TXQ, UART_MSG, portMAX_DELAY);
			break;
		}
	}
}