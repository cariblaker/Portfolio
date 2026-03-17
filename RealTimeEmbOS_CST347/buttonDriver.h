/*
 * buttonDriver.h
 *
 * Created: 1/28/2024 5:16:33 PM
 *  Author: carib
 * modified: 3/12/24 - new defines for button interrupts
 */ 


#ifndef BUTTONDRIVER_H_
#define BUTTONDRIVER_H_

void initializeButtonDriver(void);
uint8_t readButton(uint8_t uiButtonNum);
uint8_t detectButtonPress(uint8_t uiButtonNum);
void button_handler(uint32_t id, uint32_t mask);

// These are the defines for the onboard button. They are already defined for you.
// you will need to make similar defines for the external buttons
#define PIN_PUSHBUTTON_1_MASK  PIO_PA2
#define PIN_PUSHBUTTON_1_PIO   PIOA
#define PIN_PUSHBUTTON_1_ID    ID_PIOA
#define PIN_PUSHBUTTON_1_TYPE  PIO_INPUT
#define PIN_PUSHBUTTON_1_ATTR  (PIO_PULLUP | PIO_DEBOUNCE | PIO_IT_RISE_EDGE)
#define PIN_PUSHBUTTON_1_IRQn  PIOA_IRQn

#define EXT_BUTTON_1_MASK  PIO_PA16
#define EXT_BUTTON_1_PIO   PIOA
#define EXT_BUTTON_1_ID    ID_PIOA
#define EXT_BUTTON_1_TYPE  PIO_INPUT
#define EXT_BUTTON_1_ATTR  (PIO_PULLUP | PIO_DEBOUNCE | PIO_IT_RISE_EDGE)
#define EXT_BUTTON_1_IRQn  PIOA_IRQn

#define EXT_BUTTON_2_MASK  PIO_PA11
#define EXT_BUTTON_2_PIO   PIOA
#define EXT_BUTTON_2_ID    ID_PIOA
#define EXT_BUTTON_2_TYPE  PIO_INPUT
#define EXT_BUTTON_2_ATTR  (PIO_PULLUP | PIO_DEBOUNCE | PIO_IT_RISE_EDGE)
#define EXT_BUTTON_2_IRQn  PIOA_IRQn

#define EXT_BUTTON_3_MASK  PIO_PD25
#define EXT_BUTTON_3_PIO   PIOD
#define EXT_BUTTON_3_ID    ID_PIOD
#define EXT_BUTTON_3_TYPE  PIO_INPUT
#define EXT_BUTTON_3_ATTR  (PIO_PULLUP | PIO_DEBOUNCE | PIO_IT_RISE_EDGE)
#define EXT_BUTTON_3_IRQn  PIOD_IRQn


#endif /* BUTTONDRIVER_H_ */