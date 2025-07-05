////////////////////////////////////////////////////////////////////////////////
// File:	keypad.S
// Author:	Cari Blaker
////////////////////////////////////////////////////////////////////////////////
    
    
#include <xc.h>
.global keypad_input_pin
    
.ent keypad_input_pin
    keypad_input_pin:
    //#1--energize row by outputting PORTDCLR w/ row_mask
    la t1, row_mask
    lw t0, 0(t1)
    la t1, PORTDCLR
    sw t0, 0(t1)
    
    //#2--input PORTB pins
    la t1, PORTB
    lw t0, 0(t1)		//PORTB pin info now in t0
    //lw t0, PORTB
    
    //#3 --mask off portB pins except RB0, RB1, & RB3 (and with 0xb)
    andi t0, t0, 0xb		//masked value in t0
    
    //#4 --input PORTG pins
    la t1, PORTG
    lw t2, 0(t1)		//PORTG pininfo now in t2
    
    //#5--mask off port g bits except RG9 by anding w/ 0x200
    andi t2, t2, 0x200		//masked port g now in t2
    
    //#6--shift right rg9 by 7 places
    srl t2, t2, 7
    
    //#7 --compose rb3, rg9, rb1 & rb0 by oring 3 & 6 results
    or t0, t0, t2		//composite now in t0
    
    //#8    --sense col value by anding composite bits with col_mask
    lw t2, col_mask
    or t0, t0, t2		//col value now in t0
    
    //#9 set v0 to 1 or 0 appropriately --so, if there IS a col value, 
    li v0, 0
    beqz t0, skip		//if t0 is 0, keep the 0 in v0 and skip to the PORTD stuff
    nop
    li v0, 1			//if t0 is NOT 0, put a 1 in v0
    
    skip:
    //#10   --de-energize all rows
    la t2, PORTDSET
    li t0, 0xf
    lw t0, 0(t2)
    
    jr ra
    nop
    
 .end keypad_input_pin

