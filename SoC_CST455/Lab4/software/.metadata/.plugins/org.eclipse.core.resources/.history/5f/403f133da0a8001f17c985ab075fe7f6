#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <unistd.h>
#include "system.h"
#include "io.h"
#include "FreeRTOS.h"
#include "task.h"
#include "timers.h"
#include "semphr.h"

#define TASK_STACKSIZE 2048
#define LED_TASK_PRIORITY (tskIDLE_PRIORITY + 1)

int ms_slept = 750 / portTICK_PERIOD_MS;

SemaphoreHandle_t g_mutex;


void led_task(void* pvParameters) {
    uint16_t count = 0;             // For the up-counter
    uint16_t cylon_count = 0;		// For the cylon pattern
    uint8_t mode = 0;               // 0: Blank, 1: Cylon, 2: Up-counter, 3: Custom pattern
    uint32_t button_state;
    uint32_t prev_button_state = 0; // Store the previous button state
    uint8_t custom_count = 0;       // Separate counter for the custom LED pattern

    while (1) {
        xSemaphoreTake(g_mutex, portMAX_DELAY);
        printf("Hellooooo from led_task!!!\n");

        // Read the current button state
        button_state = IORD(BUTTONS_0_BASE, 0);

        // Check for button releases by looking for a high-to-low transition
        if ((prev_button_state & 0x1) && !(button_state & 0x1)) { // Button 0 released
            mode = 0; // Blank LEDs
        }
        else if ((prev_button_state & 0x2) && !(button_state & 0x2)) { // Button 1 released
            mode = 1; // Cylon pattern
        }
        else if ((prev_button_state & 0x4) && !(button_state & 0x4)) { // Button 2 released
            mode = 2; // Up-counter pattern
        }
        else if ((prev_button_state & 0x8) && !(button_state & 0x8)) { // Button 3 released
            mode = 3; // Custom pattern
        }

        // Set LEDs based on the current mode
        switch (mode) {
            case 0:
                IOWR(LEDS_BASE, 0, 0x0); // Blank LEDs
                break;

            case 1:
                // Cylon pattern
                IOWR(LEDS_BASE, 0, 1 << (cylon_count % 10));
                cylon_count++;
                if (cylon_count >= 10) cylon_count = 0;
                break;

            case 2:
                // Up-counter pattern
                IOWR(LEDS_BASE, 0, count);
                count++;
                if (count == 1024) count = 0;
                break;

            case 3:
                // Custom expanding and contracting pattern
                switch (custom_count) {
                    case 0: IOWR(LEDS_BASE, 0, 0x201); break;   // 10 0000 0001
                    case 1: IOWR(LEDS_BASE, 0, 0x303); break;   // 11 0000 0011
                    case 2: IOWR(LEDS_BASE, 0, 0x387); break;   // 11 1000 0111
                    case 3: IOWR(LEDS_BASE, 0, 0x3CF); break;   // 11 1100 1111
                    case 4: IOWR(LEDS_BASE, 0, 0x3FF); break;   // 1111111111
                    case 5: IOWR(LEDS_BASE, 0, 0x1FE); break;   // 01 1111 1110
                    case 6: IOWR(LEDS_BASE, 0, 0x0FC); break;   // 00 1111 1100
                    case 7: IOWR(LEDS_BASE, 0, 0x078); break;   // 00 0111 1000
                    case 8: IOWR(LEDS_BASE, 0, 0x030); break;   // 00 0011 0000
                    case 9: IOWR(LEDS_BASE, 0, 0x000); break;   // 0000000000
                }
                custom_count++;
                if (custom_count >= 10) custom_count = 0; // Reset custom_count after completing the pattern
                break;
        }

        printf("Mode = %u, Count = %u, Custom Count = %u\r\n", mode, count, custom_count);

        // Update previous button state
        prev_button_state = button_state;

        xSemaphoreGive(g_mutex);
        vTaskDelay(ms_slept);
    }
}



void seg7_task(void* pvParameters) {
	uint16_t SW_OP, num1, num2, most_sig1, least_sig1, most_sig2, least_sig2, num3, most_sig3, least_sig3;

	while (1) {
		xSemaphoreTake(g_mutex, portMAX_DELAY);

		// Get the operation code from switches 8 & 9
		SW_OP = (IORD(SWITCHES_0_BASE, 0) >> 8) & 0x03;

		// Get the first number from switches 0 - 3
		num1 = IORD(SWITCHES_0_BASE, 0) & 0x0F;

		// Get the second number from switches 4 - 7
		num2 = (IORD(SWITCHES_0_BASE, 0) >> 4) & 0x0F;

		// Decode num1 and num2 to most & least significant digits
		most_sig1 = num1 / 10;
		least_sig1 = num1 % 10;
		most_sig2 = num2 / 10;
		least_sig2 = num2 % 10;

		if (SW_OP == 0x00){					// If SW 8 & 9 are 00, blank all the displays
			IOWR(SEG7S_0_BASE, 0, 0xFF);
			IOWR(SEG7S_1_BASE, 0, 0xFF);
			IOWR(SEG7S_2_BASE, 0, 0xFF);
			IOWR(SEG7S_3_BASE, 0, 0xFF);
			IOWR(SEG7S_4_BASE, 0, 0xFF);
			IOWR(SEG7S_5_BASE, 0, 0xFF);
		}
		else {								// Otherwise, write num1 & num2 to HEX5-HEX2
			IOWR(SEG7S_3_BASE, 0, most_sig1);
			IOWR(SEG7S_2_BASE, 0, least_sig1);

			IOWR(SEG7S_5_BASE, 0, most_sig2);
			IOWR(SEG7S_4_BASE, 0, least_sig2);
			switch (SW_OP){
				case 0x01:					// addition
					num3 = num1 + num2;
					break;
				case 0x02:					// subtraction
					num3 = num2 - num1;
					break;
				case 0x03:					// multiplication
					num3 = num1 * num2;
					printf("%u * %u = %u\n", num1, num2, num3);
					break;

					}
			most_sig3 = num3 / 10;
			least_sig3 = num3 % 10;
			IOWR(SEG7S_1_BASE, 0, most_sig3);
			IOWR(SEG7S_0_BASE, 0, least_sig3);
		}

		xSemaphoreGive(g_mutex);

		vTaskDelay(ms_slept);
	}
}



int main(){
	printf("Hello FreeRTOS from main! \n");

	g_mutex = xSemaphoreCreateMutex();

	if (pdFAIL == xTaskCreate( led_task, "led_task", TASK_STACKSIZE, &ms_slept, LED_TASK_PRIORITY, NULL) )
	{
		printf("LED task creation failed...\n");
	}

	if (pdFAIL == xTaskCreate( seg7_task, "seg7_task", TASK_STACKSIZE, &ms_slept, LED_TASK_PRIORITY, NULL) )
	{
		printf("Seven Segment task creation failed...\n");
	}

	vTaskStartScheduler();


	while (1) { }
	return 0;
}
