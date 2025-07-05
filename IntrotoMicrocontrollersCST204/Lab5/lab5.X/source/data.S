////////////////////////////////////////////////////////////////////////////////
// File:	data.S
// Author:	Cari Blaker
////////////////////////////////////////////////////////////////////////////////
#include <xc.h>

// Used in main.S and app_heartbeat.S
.global	FLAG_10MS
.global	heartbeat_state
.global	heartbeat_count
    
//keypad variables
.global KEY_PRESSED
.global row_mask
.global col_mask
.global svc_keypad_state
.global FLASHER
.global app_timer32_state

.data
    FLAG_10MS:		.word	0
    heartbeat_state:	.word	0
    heartbeat_count:	.word	0
    KEY_PRESSED:	.word	0
    row_mask:		.word	0b0001
    col_mask:		.word	0b0001
    svc_keypad_state:	.word	0
    FLASHER:		.word	0
    app_timer_32_state:	.word	0