 #include    <xc.h>

// use macros for readability
//// This can be placed in a file called macros_h.h and included
//// using #include <macros_h.h>. If done, a new folder called
//// "include" should be created in the project folder to contain
//// the .h files. The files must then be added to the project
//// Header Files folder. Using .h files is optional.
#define LCD_CMD         0
#define LCD_DATA        1
#define LCD_CLEAR_CMD   0x01
#define	DATA_ADDR_COMM	0x80

extern  int lcd_test_state;
extern  int lcd_test_count;

extern  char    LCD_TEST_LINE1[20];
extern  char    LCD_TEST_LINE2[20];

extern  void    lcd_wait_for_not_busy(void);
extern  void    lcd_write(int RS_SEL, int CMD_ADDR);
extern  void    lcd_write_string(char LCD_BUFFER[]);

////////////////////////////////////////////////////////////////////////////////
// This is the only function that controls LINE 1 and LINE 2 of the LCD.
////////////////////////////////////////////////////////////////////////////////
void    app_test_lcd(void)
{
    // count 1-100
    if (lcd_test_count < 100)
    {
        lcd_test_count++;
    }
    else
    {
        lcd_test_count = 1;
    }
    
    // check state value
    switch (lcd_test_state)
    {
        case 0:
            if (lcd_test_count == 100)
            {
                lcd_wait_for_not_busy();  // << 10 ms
                lcd_write(LCD_CMD, DATA_ADDR_COMM | 0x00);  // << 10 ms
                lcd_write_string(LCD_TEST_LINE1);  // << 10 ms
                lcd_test_state = 1;
            }
            break;
        case 1:
            if (lcd_test_count == 100)
            {
                lcd_wait_for_not_busy();  // << 10 ms
                lcd_write(LCD_CMD, LCD_CLEAR_CMD);  // << 10 ms
                lcd_test_state = 2;
            }
            break;
        case 2:
            if (lcd_test_count == 100)
            {
                lcd_wait_for_not_busy();  // << 10 ms
                lcd_write(LCD_CMD, DATA_ADDR_COMM | 0x40);  // << 10 ms
                lcd_write_string(LCD_TEST_LINE2);  // << 10 ms
                lcd_test_state = 3;
            }
            break;
        case 3:
            if (lcd_test_count == 100)
            {
                lcd_wait_for_not_busy();  // << 10 ms
                lcd_write(LCD_CMD, LCD_CLEAR_CMD);  // << 10 ms
                lcd_test_state = 0;
            }
            break;
        default:
            while(1);
    }
    // process state code for each state
}