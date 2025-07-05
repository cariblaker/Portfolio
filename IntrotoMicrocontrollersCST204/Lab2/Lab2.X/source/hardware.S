////////////////////////////////////////////////////////////////////////////////
// File:	hardware.S
// Author:	Cari Blaker
////////////////////////////////////////////////////////////////////////////////
    
    
#include <xc.h>	    //xe.h?


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
    la v1, PORTACLR
    li a0, 0b10000000
    sw a0, 0(v1)
    la v1, ODCACLR
    sw a0, 0(v1)
    la v1, TRISACLR
    sw a0, 0(v1)
    jr ra
    nop
.end gpio_config