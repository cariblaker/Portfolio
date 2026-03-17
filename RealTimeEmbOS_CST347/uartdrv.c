/*************************************************************
* Author: Cari Blaker
* Filename: uartdrv.c
* Date Created: 2/18/2024 8:26:21 PM
* Modifications: 2/19/2024 - modified UARTPutC() to send start/
* stop bits, although I'm still not sure that's necessary, and
* added documentation
* 3/8/24 - added UART handler function
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

#include "OITExpansionBoardDefines.h"
#include "uartdrv.h"

/**********************************************************************
* Purpose: This function initializes the UART
*
************************************************************************/
uint8_t initUART(Uart * p_Uart)
{
	uint32_t cd = 0;
	uint8_t retVal = 0;
	
	// configure UART pins
	ioport_set_port_mode(IOPORT_PIOA, PIO_PA9A_URXD0 | PIO_PA10A_UTXD0, IOPORT_MODE_MUX_A);
	ioport_disable_port(IOPORT_PIOA, PIO_PA9A_URXD0 | PIO_PA10A_UTXD0);
	sysclk_enable_peripheral_clock(ID_UART0);

	// Configure UART Control Registers
	// Reset and Disable RX and TX
	p_Uart->UART_CR = UART_CR_RSTRX | UART_CR_RSTTX | UART_CR_RXDIS | UART_CR_TXDIS;

	// Check and configure baudrate
	// Asynchronous, no oversampling
	cd = (sysclk_get_peripheral_hz() / UART_SERIAL_BAUDRATE) / UART_MCK_DIV;
	if(cd < UART_MCK_DIV_MIN_FACTOR || cd > UART_MCK_DIV_MAX_FACTOR)
	{
		retVal = 1;
	}
	
	if(retVal != 1)
	{
		// Set The Actual BAUD to Control Register
		p_Uart->UART_BRGR = cd;

		// Configure Mode
		p_Uart->UART_MR = UART_SERIAL_PARITY;
		
		// Disable PDC Channel
		p_Uart->UART_PTCR = UART_PTCR_RXTDIS | UART_PTCR_TXTDIS;
		
		// Enable RX and TX
		p_Uart->UART_CR = UART_CR_RXEN | UART_CR_TXEN;
		
		// Enable RX Interrupt
		p_Uart->UART_IER = UART_IER_RXRDY;
		NVIC_SetPriority(UART0_IRQn, 5);
		NVIC_EnableIRQ(UART0_IRQn);
	}

	
	return retVal;
}

/**********************************************************************
* Purpose: This function transmits a character on the UART
* Inputs:
************************************************************************/
void UARTPutC(Uart * p_Uart, char data){
	// Wait for Transmitter to be Ready
	while((p_Uart->UART_SR & UART_SR_TXRDY) == 0);
	
	// Send data
	p_Uart->UART_THR = data;
}

/**********************************************************************
* Purpose: This function transmits a string on the UART
* Inputs: a pointer to the UART, the char* of the string to be transmitted,
* and the length of the string to be transmitted
************************************************************************/
void UARTPutStr(Uart * p_Uart, char * data, uint8_t len){
	for (int i = 0; i < len; i++){
		UARTPutC(p_Uart, data[i]);
	}
}

/**********************************************************************
* Purpose: This function handles UART0 RX betwixt ISR & Queue
************************************************************************/
void UART0_Handler()
{
	uint8_t data = '\0';
	uint32_t uiStatus = EDBG_UART->UART_SR;
	BaseType_t xHigherPriorityTaskWoken;

	if(uiStatus & UART_SR_RXRDY)
	{
		data = (uint8_t) EDBG_UART->UART_RHR;
		// Send Queue message to task
		xQueueSendToBack(RXQ, &data, 10);
		portEND_SWITCHING_ISR(xHigherPriorityTaskWoken);
	}
}
