////////////////////////////////////////////////////////////////////////////////
// File:	app_heartbeat.S
// Author:	Cari Blaker
////////////////////////////////////////////////////////////////////////////////
    
#include <xc.h>
.global app_heartbeat
.text
.set noreorder
    
.ent app_heartbeat
    //Stack Frame Preamble
    //made space for ra, fp, and a0-a3
    addiu sp, sp, -68
    sw ra, 64(sp)
    sw fp, 60(sp)
    addu fp, sp, zero   // move fp to sp
    
    app_heartbeat:
	la v1, heartbeat_count
	lw v1, 0(v1)
	addiu v1, v1, 1
	sw v1, heartbeat_count
	beq v1, 99, determine_transition
	nop
	j back_to_main
	nop
	
	
	determine_transition:
	    la v1, heartbeat_state
	    lw v1, 0(v1)
	    beq v1, 0, switch_to_one
	    nop
	    beq v1, 1, switch_to_zero
	    nop
	
	switch_to_one:
	    la v1, PORTASET
	    li a0, 0b10000000
	    sw a0, 0(v1)
	    la v1, heartbeat_count
	    sw zero, 0(v1)
	    la v1, heartbeat_state
	    li a0, 1
	    sw a0, 0(v1)
	    j back_to_main
	    nop
	    
	switch_to_zero:
	    la v1, PORTACLR
	    li a0, 0b10000000
	    sw a0, 0(v1)
	    la v1, heartbeat_count
	    sw zero, 0(v1)
	    la v1, heartbeat_state
	    li a0, 0
	    sw a0, 0(v1)
	   
	back_to_main:
	    jr ra
	    nop
	    
    addu sp, fp, zero
    lw ra, 64(sp)
    lw fp, 60(sp)
    addiu sp, sp, 68
.end app_heartbeat
	
	
	