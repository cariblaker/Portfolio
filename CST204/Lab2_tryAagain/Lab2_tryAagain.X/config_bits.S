////////////////////////////////////////////////////////////////////////////////
// File:	config_bits.S
// Author:	Cari Blaker
////////////////////////////////////////////////////////////////////////////////
	
#include <xc.h>
	// For DEVCFG2
	// FPLLIDIV = DIV_2, FPLLMUL  = MUL_20, and FPLLODIV = DIV_4
.section .config_BFC02FF4, code
.word 0xFFFAFFD9

	// For DEVCFG1
	// Set FNOSC = PRIPLL, POSCMOD = XT, and FWDTEN = OFF
.section .config_BFC02FF8, code
.word 0xFF7FFDFB

