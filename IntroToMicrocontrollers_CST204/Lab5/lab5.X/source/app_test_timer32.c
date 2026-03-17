/* ************************************************************************** */
/* File Name: app_test_timer32.c
    Author: Cari Blaker */
/* ************************************************************************** */
#include <xc.h>
extern int KEY_PRESSED, FLASHER;

void app_test_timer32(void) {
    
    switch (KEY_PRESSED){
        case 0:
            FLASHER = 0;
            break;
         
        case 1:
            FLASHER = 1;
            IFS0SET = 0x1000;
            break;
    }
    
    
}