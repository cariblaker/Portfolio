
////////////////////////////////////////////////////////////////////////////////
// File:	main.S
// Author:	Cari Blaker
////////////////////////////////////////////////////////////////////////////////
#include <xc.h>
.global main
.text
.set noreorder
.ent main
main:
    
     jal waitstates_config
    nop
    
    jal gpio_config
    nop
    
    jal intsys_config
    nop
    
    jal timer1_config
    nop

    
    while_1:
    wait_for_flag_10ms:
	la t1, FLAG_10MS
	lw t0, 0(t1)
	beq t0, zero, wait_for_flag_10ms
	nop
	
    found_flag_10ms:
	la t1, FLAG_10MS
	sw zero, 0(t1)

    perform_tasks:
	jal app_heartbeat
	nop
	    
	jal keypad_input_pin
	nop
	jal svc_keypad
	nop
	jal app_test_keypad
	nop
	
	j while_1
	nop
	

.end main
	