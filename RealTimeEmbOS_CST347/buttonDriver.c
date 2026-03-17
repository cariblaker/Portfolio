/*************************************************************
* Author: Cari Blaker
* Filename: buttonDriver.c
* Created: 1/28/2024 5:19:58 PM
* Modifications:
* 3/12/24 - made button ISR
**************************************************************/
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
#include "buttonDriver.h"
#include "OITExpansionBoard.h"
#include "OITExpansionBoardDefines.h"


int BUTTON_STATE;
extern TaskHandle_t button_task;


/**********************************************************************
* Purpose: This function assigns ports to buttons, makes them inputs,
* & assigns them sense mode
************************************************************************/

void initializeButtonDriver(void){
	
	//config for onboard button
	pio_configure(PIN_PUSHBUTTON_1_PIO, PIN_PUSHBUTTON_1_TYPE, PIN_PUSHBUTTON_1_MASK, PIN_PUSHBUTTON_1_ATTR);
	pio_set_debounce_filter(PIN_PUSHBUTTON_1_PIO, PIN_PUSHBUTTON_1_MASK, 10);
	pio_handler_set(PIN_PUSHBUTTON_1_PIO, PIN_PUSHBUTTON_1_ID, PIN_PUSHBUTTON_1_MASK, PIN_PUSHBUTTON_1_ATTR, button_handler);
	pio_handler_set_priority(PIN_PUSHBUTTON_1_PIO, PIN_PUSHBUTTON_1_IRQn, 5);
	pio_enable_interrupt(PIN_PUSHBUTTON_1_PIO, PIN_PUSHBUTTON_1_MASK);

	//config EXT1 button1
	pio_configure(EXT_BUTTON_1_PIO, EXT_BUTTON_1_TYPE, EXT_BUTTON_1_MASK, EXT_BUTTON_1_ATTR);
	pio_set_debounce_filter(EXT_BUTTON_1_PIO, EXT_BUTTON_1_MASK, 10);
	pio_handler_set(EXT_BUTTON_1_PIO, EXT_BUTTON_1_ID, EXT_BUTTON_1_MASK, EXT_BUTTON_1_ATTR, button_handler);
	pio_handler_set_priority(EXT_BUTTON_1_PIO, EXT_BUTTON_1_IRQn, 5);
	pio_enable_interrupt(EXT_BUTTON_1_PIO, EXT_BUTTON_1_MASK);

	//config EXT1 button2
	pio_configure(EXT_BUTTON_2_PIO, EXT_BUTTON_2_TYPE, EXT_BUTTON_2_MASK, EXT_BUTTON_2_ATTR);
	pio_set_debounce_filter(EXT_BUTTON_1_PIO, EXT_BUTTON_1_MASK, 10);
	pio_handler_set(EXT_BUTTON_2_PIO, EXT_BUTTON_2_ID, EXT_BUTTON_2_MASK, EXT_BUTTON_2_ATTR, button_handler);
	pio_handler_set_priority(EXT_BUTTON_2_PIO, EXT_BUTTON_2_IRQn, 5);
	pio_enable_interrupt(EXT_BUTTON_2_PIO, EXT_BUTTON_2_MASK);

	//config EXT1 button3
	pio_configure(EXT_BUTTON_3_PIO, EXT_BUTTON_3_TYPE, EXT_BUTTON_3_MASK, EXT_BUTTON_3_ATTR);
	pio_set_debounce_filter(EXT_BUTTON_1_PIO, EXT_BUTTON_1_MASK, 10);
	pio_handler_set(EXT_BUTTON_3_PIO, EXT_BUTTON_3_ID, EXT_BUTTON_3_MASK, EXT_BUTTON_3_ATTR, button_handler);
	pio_handler_set_priority(EXT_BUTTON_3_PIO, EXT_BUTTON_3_IRQn, 5);
	pio_enable_interrupt(EXT_BUTTON_3_PIO, EXT_BUTTON_3_MASK);
}

/**********************************************************************
* Purpose: This function returns the current level of a given button
* Precondition:
*		uiButtonNum - a number 1 through 4, indicating which button on
*					the extension board to read
* Postcondition:
*		pin_level - the found pin level of the requested button
************************************************************************/

uint8_t readButton(uint8_t uiButtonNum){
	uint8_t pin_level;
	
	switch(uiButtonNum){
		case 1:
		pin_level = ioport_get_pin_level(EXT1_PUSH_BUTTON_1);
		break;
		case 2:
		pin_level = ioport_get_pin_level(EXT1_PUSH_BUTTON_2);
		break;
		case 3:
		pin_level = ioport_get_pin_level(EXT1_PUSH_BUTTON_3);
		break;
		case 4:
		pin_level = ioport_get_pin_level(EXT1_PUSH_BUTTON_4);
		break;
	}
	
	return pin_level;
}

/**********************************************************************
* Purpose: This function locks out a button press. If there is no press,
* it returns the unpressed state of the pin. If a button is pressed, it
* waits until it is released, and then sends the signal for a pressed
* button.
* Precondition:
*		uiButtonNum - a number 1 through 4, indicating which button on
*					the extension board to lockout
* Postcondition:
*		pin_level - the found pin level of the requested button
************************************************************************/
uint8_t detectButtonPress(uint8_t uiButtonNum){

	if (readButton(uiButtonNum) == IOPORT_PIN_LEVEL_HIGH){
		return IOPORT_PIN_LEVEL_HIGH;
	}
	
	while (readButton(uiButtonNum) == IOPORT_PIN_LEVEL_LOW);
	return IOPORT_PIN_LEVEL_LOW;
}

/**********************************************************************
* Purpose: This function identifies a button press, changes the state of
* the global button tracking variable, and notifies the button task to
* process the action.
************************************************************************/
void button_handler(uint32_t id, uint32_t mask)
{
	BaseType_t xHigherPriorityTaskWoken = pdFALSE;

	if ((EXT_BUTTON_1_ID == id) && (EXT_BUTTON_1_MASK == mask)) {
		//change the global button state so that the button task can recognize which button was pressed
		BUTTON_STATE = 1;
		// Then wake up the button Task to process.
		vTaskNotifyGiveFromISR(button_task, &xHigherPriorityTaskWoken);
	}
	else if ((EXT_BUTTON_2_ID == id) && (EXT_BUTTON_2_MASK == mask)) {
		BUTTON_STATE = 2;
		vTaskNotifyGiveFromISR(button_task, &xHigherPriorityTaskWoken);
	}
	else if ((EXT_BUTTON_3_ID == id) && (EXT_BUTTON_3_MASK == mask)) {
		BUTTON_STATE = 3;
		vTaskNotifyGiveFromISR(button_task, &xHigherPriorityTaskWoken);
	}

	portEND_SWITCHING_ISR(xHigherPriorityTaskWoken);
}