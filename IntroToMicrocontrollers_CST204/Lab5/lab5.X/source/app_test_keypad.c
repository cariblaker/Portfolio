/* ************************************************************************** */
/** file name: app_test_keypad.c
 * author: Cari Blaker
 */
#include <xc.h>

extern int row_mask, col_mask, KEY_PRESSED;

#define LCD_BUFFER_SIZE 16
char LCD_BUFFER[LCD_BUFFER_SIZE];
int row, col;

void app_test_keypad(void) {
    static int state = 0;

    switch (state) {
        case 0:
            if (KEY_PRESSED == 1) {
                state = 1;
                switch (row_mask) {
                    case 0b1110: row = 0; break;
                    case 0b1101: row = 1; break;
                    case 0b1011: row = 2; break;
                    case 0b0111: row = 3; break;
                }
                switch (col_mask) {
                    case 0b1110: col = 0; break;
                    case 0b1101: col = 1; break;
                    case 0b1011: col = 2; break;
                    case 0b0111: col = 3; break;
                }
                // Manually copy the message into LCD_BUFFER
                int i;
                char message[] = "Key Pressed: row  , col  ";
                for (i = 0; i < sizeof(message) - 1; i++) {
                    LCD_BUFFER[i] = message[i];
                }
                LCD_BUFFER[14] = row + '0';  // Convert row value to character and assign it to the appropriate position
                LCD_BUFFER[21] = col + '0';  // Convert col value to character and assign it to the appropriate position
                LCD_BUFFER[sizeof(message) - 1] = '\0';  // Add the null-terminating character
            } else {
                state = 0;
                // Manually copy the message into LCD_BUFFER
                int i;
                char message[] = "No Key Pressed";
                for (i = 0; i < sizeof(message); i++) {
                    LCD_BUFFER[i] = message[i];
                }
            }
            break;

        case 1:
            if (KEY_PRESSED == 0) {
                state = 0;
                // Manually copy the message into LCD_BUFFER
                int i;
                char message[] = "No Key Pressed";
                for (i = 0; i < sizeof(message); i++) {
                    LCD_BUFFER[i] = message[i];
                }
            }
            break;
    }
}
/* *****************************************************************************
 End of File
 */
