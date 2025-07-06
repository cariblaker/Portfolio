////////////////////////////////////////////////////////////////////////////////
// File:	hardware.S
// Author:	Cari Blaker
////////////////////////////////////////////////////////////////////////////////
    
#include <xc.h>


.global waitstates_config
.global gpio_config
.global lcd_config

    
.ent waitstates_config   
waitstates_config:
    la v1, CHECONCLR
    li v0, 0b111
    sw v0, 0(v1)
    jr ra
    nop
.end waitstates_config
    

.ent gpio_config
gpio_config:
    //led gpio config stuff
    //clear bit 7 of port A
    la v1, PORTACLR
    li a0, 0b10000000
    sw a0, 0(v1)
    la v1, ODCACLR
    sw a0, 0(v1)
    la v1, TRISACLR
    sw a0, 0(v1)
    jr ra
    nop
    
    //lcd gpio config stuff
    //port B clear bit 15
    la v1, PORTBCLR
    li a0, 0x4000
    sw a0, 0(v1)
    la v1, ODCBCLR
    sw a0, 0(v1)
    la v1, TRISBCLR
    sw a0, 0(v1)
    //port D clear bits 4&5
    la v1, PORTDCLR
    li a0, 0b110000
    sw a0, 0(v1)
    la v1, ODCDCLR
    sw a0, 0(v1)
    la v1, TRISDCLR
    sw a0, 0(v1)
    jr ra
    nop
.end gpio_config
    
    

	

.ent lcd_config
// lcd_config: Stack frame: {{{
//		[Register save]
//	ra		20
//	fp		16
//		[Parameter space]
//	a3		12
//	a2		8
//	a1		4
//	a0		0
////////////////////////////////////////////////////////////////////////////////

lcd_config:
    // Stack setup
    addiu sp, sp, -24					// Allocate stack space
    sw	ra, 20(sp)
    sw	fp, 16(sp)
    move fp, sp

    // Wait for 40ms (200ns * 5 = 1ms, 200 times)
    li	a0, 200000						// 200000 times for 40ms wait
    jal instr_busy_wait
    nop

    // lcd_write command 0x38, a0 = 0, a1 = 0x38
    li	a0, 0
    li	a1, 0x38						// 8bit interface, 2 line disp, 5x8 chars
    jal	lcd_write
    nop

    // lcd_wait
    jal lcd_wait_for_not_busy
    nop

    // lcd_write command 0x06
    li	a0, 0 
    li	a1, 0x06						// Increment addr, no shift
    jal	lcd_write 
    nop

    // lcd_wait
    jal lcd_wait_for_not_busy
    nop
 
    // lcd_write command 0x0F
    li		a0,		0
    li		a1,		0x0F						// Display on, cursor on, blink
    jal		lcd_write
    nop

    // lcd_wait
    jal lcd_wait_for_not_busy
    nop

    // lcd_write command 0x80
    li	a0, 0
    li	a1, 0x80						// Set address = 0
    jal	lcd_write
    nop

    // lcd_wait
    jal lcd_wait_for_not_busy
    nop

    // lcd_write command 0x01
    li		a0, 0
    li		a1, 0x01						// clear display
    jal		lcd_write
    nop

    // Stack restore
    move	sp, fp
    lw		fp, 16(sp)
    lw		ra, 20(sp)
    addiu	sp, sp,	24					// Restore stack space
    jr	ra
    nop

.end lcd_config