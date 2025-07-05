////////////////////////////////////////////////////////////////////////////////
// File:	lab4tb.S
// Author:	Cari Blaker
////////////////////////////////////////////////////////////////////////////////
    
#include <xc.h>
    
.global main
.global timer1_delay_b

.text
.set noreorder
    
.ent main
main:
    la t0, LATACLR	
    li t1, 0xff
    la t0, LATASET
    sw t1, 0(t0)
    li t1, 0xa5
    sw t1, 0(t0)
    la t0, ODCACLR
    li t1, 0xff
    sw t1, 0(t0)		//configure porta pins 7:0 to regular digital outputs (not open drain)
    la t0, TRISACLR
    sw t1, 0(t0)		//output configuration
    
    la t0, T1CONSET
    li t1, 0x10			//bit 5 = 0, bit 4 = 1 to create division by 8
    sw t1, 0(t0)
    la t0, T1CONCLR
    li t1, 0x20
    sw t1, 0(t0)
    
    la t0, IFS0CLR		
    li t1, 0x10			//clear bit #4 of the IFS0 reg
    sw t1, 0(t0)
    
    la t0, SYSKEY		//unlock sequence part 3)main a)iii.
    li t1, 0x0
    sw t1, 0(t0)
    li t1, 0xaa996655
    sw t1, 0(t0)
    li t1, 0x556699aa
    sw t1, 0(t0)
    
    la t0, OSCCONSET		//bits 20-19 should be 10 to div by 64
    li t1, 0x100000		//0000 0000 000-1 0-000 0000 0000 0000 0000
    sw t1, 0(t0)
    la t0, OSCCONCLR
    li t1, 0x80000		//0000 0000 8 0 0 0 0 0
    sw t1, 0(t0)
    
    la t0, SYSKEY		
    li t1, 0x0
    sw t1, 0(t0)
    
    /*la t0, T1CON		//<---------confusing. set to div and then cleared??
    li t1, 0x0		
    sw t1, 0(t0)*/
    
    main_loop:
	la t0, PORTACLR		//clear all the bits in port a
	li t1, 0xff
	sw t1, 0(t0)
	
	la t0, PORTASET
	li t1, 0xa5		//part 1, 3)b)i.
	sw t1, 0(t0)
	
	li a0, 62500		
	jal timer1_delay_b			    
	nop
	
	la t0, PORTACLR		//clear all the bits in port a
	li t1, 0xff
	sw t1, 0(t0)

	la t0, PORTASET
	li t1, 0x5a		//part 1, 3)b)iii.
	sw t1, 0(t0)
	
	li a0, 62500		
	jal timer1_delay_b			    
	nop
	

    j main_loop			//continuous loop
    nop
    
.end main
	

.ent timer1_delay_b
timer1_delay_b:
//Stack Frame Preamble
    //made space for ra, fp, and a0-a3
    addiu sp, sp, -68
    sw ra, 64(sp)
    sw fp, 60(sp)
    addu fp, sp, zero   // move fp to sp

    la t0, TMR1				    //clear timer 1 count value--clear all bits
    li t1, 0x0
    sw t1, 0(t0)

    la t0, PR1				    //the lab does say to write all bits at once, and i did not do it at once. so maybe that's the prob!
    sw a0, 0(t0)

    la t0, T1CONSET			    //start timer
    li t1, 0x8000			    //set only bit 15
    sw t1, 0(t0)
    
    timer_loop:
	la t0, IFS0				    //bit 4 of IFS0 is the T1IF bit, the flag for timer1
	lw t1, 0(t0)				    //load the word in the IFS0 register
	andi t0, t1, 0x10			    //mask to read the value of bit 4
	beqz t0, timer_loop			    //if it's zero, loop back and wait for it to be 1
	nop
	
    la t0, T1CONCLR			    //stop timer
    li t1, 0x8000			    //clear only bit 15
    sw t1, 0(t0) 
    
    la t0, IFS0CLR			    
    li t1, 0x10
    sw t1, 0(t0)			    
    
    //de-stackification
    addu sp, fp, zero
    lw ra, 64(sp)
    lw fp, 60(sp)
    addiu sp, sp, 68
    
    jr ra
    nop
    
    
.end timer1_delay_b



