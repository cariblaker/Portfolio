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
    
    