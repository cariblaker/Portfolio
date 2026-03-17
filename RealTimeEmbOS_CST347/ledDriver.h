/*
 * ledDriver.h
 *
 * Created: 1/28/2024 4:39:21 PM
 *  Author: Cari Blaker
 */ 


#ifndef LEDDRIVER_H_
#define LEDDRIVER_H_

//initializes LEDs, called from Hardware init in main.
//sets ports, and initializes values as OFF
void initializeLEDDriver(void);

//returns current state of given LED
// 0 = onboard LED, 1 = EXT_LED1, 2 = EXT_LED2, 3 = EXT_LED3
uint8_t readLED(uint8_t uiLedNum);

//sets specified LED ON/OFF --specified by uiLedValue
uint8_t setLED(uint8_t uiLedNum, uint8_t uiLedValue);

//toggles the LED
uint8_t toggleLED(uint8_t uiLedNum);


#endif /* LEDDRIVER_H_ */