////////////////////////////////////////////////////////////////////////////////
// File:	hardware.S
// Author:	Cari Blaker
////////////////////////////////////////////////////////////////////////////////
    
    
#include <xc.h>	    


.global waitstates_config
.global gpio_config
.global intsys_config
.global timer1_config
    
    
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
    
    
    //PART2 of Lab5 configure RA6 as digital output, non-open drain
    la t0, ODCACLR
    li t1, 0x00000040			//it's bit six.... 0100 0000
    sw t1, 0(t0)
    la t0, TRISACLR
    sw t1, 0(t0)
    
    jr ra
    nop
.end gpio_config
    
    
    
    //flag set, stop timer, clear flag, do work, clear timer, load period reg, start timer 
    
.ent intsys_config
    intsys_config:
	di				    //disable interrupts
	
	mfc0	t0, _CP0_CAUSE		    //get CP0 cause
	li	t1, 0x00800000		    //set IV bit.... wait, that's the 4th bit?! is that why I'm so confused?!!?! Or does IV not mean 4 here? why would we use roman numerals? lololol
	or	t0, t0, t1		    //ah, IV stands for interrupt vector. heard.
	mtc0	t0, _CP0_CAUSE		    //update CP0 cause
    
	la	t0, INTCONSET
	li	t1, 0x1000		    //set MVEC bit
	sw	t1, 0(t0)
	
	ei				    //enable interrupts
	
	jr ra
	nop
    
    
.end intsys_config
	
	
.ent timer1_config
    timer1_config:
	la t0, IFS0CLR				    //is my issue with the other labs that IFS0 doesn't have a clear or set?!?!??!?!?!
	li t1, 0x0010				    //to clear bit 4
	sw t1, 0(t0)
	
	la t0, IPC1SET					    //set priority = 6 & //subpriority = 0
	li t1, 0x00000018				    //0 0 0 0 0 0 000-1-  -1- -0- -0- -0-
	sw t1, 0(t0)
	la t0, IPC1CLR
	li t1, 0x00000007					    
	sw t1, 0(t0)
	
	la t0, IEC0				    //set T1IE (bit 4 of IEC0)					    
	lw t2, 0(t0)
	li t1, 0x00000010			    //mask for IEC0
	or t1, t1, t2
	sw t1, 0(t0)
	
	la t0, TMR1					    //clear timer 1
	li t1, 0x0
	sw t1, 0(t0)
	
	la t0, PR1					    //load period reg w/ 25000 : 10ms @pbclk = 2.5 MHz
	li t1, 25000
	sw t1, 0(t0)
	
	la t0, T1CONSET					    //turn on timer 1
	li t1, 0x8000
	sw t1, 0(t0)
	
	jr ra
	nop
	
.end timer1_config
	
	
	
.ent timer32_config
    timer32_config:					    //clear T3If = bit 12 of IFS0
	la t0, IFS0CLR
	li t1, 0x00001000				    //0001 0000 0000 0000
	sw t1, 0(t0)
	
	la t0, T2CONSET					    //set T32 = bit 3 T2CON
	li t1, 0x00000008			
	sw t1, 0(t0)
	
	la t0, IPC3SET					    //Set timer3 Priority = 5 & subpriority = 0. 
	li t1, 0x00000014				    //IPC3 bits 4-2 = 101 & bits 1-0 = 00
	sw t1, 0(t0)					    //0 0 0 0 0 0 000-1 01--00-
	la t0, IPC3CLR					    //0 0  0 0 0 0 0000 -1-0-11-
	li t1, 0x0000000b
	sw t1, 0(t0)
	 
	la t0, IEC0SET						    //set T31E = bit 12 of IEC0
	li t1, 0x10000
	sw t1, 0(t0)
	
	jr ra
	nop
	
.end timer32_config