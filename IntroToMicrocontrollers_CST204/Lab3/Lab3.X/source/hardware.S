////////////////////////////////////////////////////////////////////////////////
// File:	hardware.S
// Author:	Cari Blaker
////////////////////////////////////////////////////////////////////////////////
    
    
#include <xc.h>	    


.global waitstates_config
.global gpio_config
    
    
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
    //led config stuff
    la v1, PORTACLR
    li a0, 0b10000000
    sw a0, 0(v1)
    la v1, ODCACLR
    sw a0, 0(v1)
    la v1, TRISACLR
    sw a0, 0(v1)
    //keypad config stuff
    
    //RD3-RD0 must be digital outputs
    //establish default data value:
    la v1, PORTDSET
    li a0, 0xF			
    sw a0, 0(v1)
    //open-drain configuration
    la v1, ODCDSET			
    sw a0, 0(v1)
    //digital output configuration	
    la v1, TRISDCLR
    sw a0, 0(v1)
    
    //RB0, RB1, RB3 (or AN0 AN1 & AN3 ????) must be digital input
    la v1, AD1PCFGSET			//load what's in the AD1PCFG reg into v1
    li t1, 0x000B			//B should correlate with AN0, AN1, & AN3
    sw a0, 0(v1)			//actually sets AD1PCFG with the correct value   
    
    //RB0, RB1, RB3, & RG9 to have internal pull-ups
    la v1, CNPUESET
    li t1, 0x82C			//RB0, RB1, RB3 & RG9 are CN2, CN3, CN5, & CN11, respectively, so 82C
    sw a0, 0(v1)
    
    jr ra
    nop
.end gpio_config