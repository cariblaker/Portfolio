/* ************************************************************************** */
/* File Name: svc_keypad.c
    Author: Cari Blaker */
/* ************************************************************************** */
#include <xc.h>
extern int keypad_input_pin();
extern int row_mask, col_mask, KEY_PRESSED, svc_keypad_state;

void svc_keypad(void) {
    col_mask = 0x1;
    switch (svc_keypad_state){
        case 0:                                     //detect potential key press
            while (col_mask <= 0x8) {
                if (keypad_input_pin() == 0){       //key press detected
                    svc_keypad_state = 1;           //transition to state 1
                    return;
                }
                col_mask = (col_mask << 1);
            }
            row_mask = (row_mask << 1);
            if (row_mask >= 0x00000010) {
                row_mask = 0x00000001;
            }
            break;
        
        case 1:                                     //debounce delay state
            if (keypad_input_pin() == 0) {
                KEY_PRESSED = 1;
                svc_keypad_state = 2;               //transition to state 2
            }
            else {
                KEY_PRESSED = 0;
                svc_keypad_state = 0;
            }
            break;
        case 2:                                     //detect key release
            if (keypad_input_pin() == 1){
                svc_keypad_state = 3;               //transition to state 3
            }
            break;
            
        case 3:
            if (keypad_input_pin() == 1) {          //release debounce state
                KEY_PRESSED = 0;                    //key is assumed to actually be released
                svc_keypad_state = 0;               //back to initial state
            }
            else {
                svc_keypad_state = 2;               //otherwise, go back to waiting for key to be released
            }
            break;
    }
}




   