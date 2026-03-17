////////////////////////////////////////////////////////////////////////////////
// File:	lab4ta.S
// Author:	Cari Blaker
////////////////////////////////////////////////////////////////////////////////
    
#include <xc.h>
    
.global main
.global timer1_delay_a

.text
.set noreorder
    
.ent main
main:
    la t0, LATACLR			//part 1, 3)a) initialize lata<7:0> to 0xa5
    li t1, 0xff
    sw t1, 0(t0)
    la t0, LATASET
    li t1, 0xa5
    sw t1, 0(t0)
    la t0, ODCACLR
    li t1, 0xff
    sw t1, 0(t0)		//configure porta pins 7:0 to regular digital outputs (not open drain)
    la t0, TRISACLR
    sw t1, 0(t0)		//output configuration
    
    la t0, T1CON		//this is 2ai--the very first instruction added to this file as part 2 of the assignment
    li t1, 0x0
    sw t1, 0(t0)
    la t0, IFS0CLR	
    li t1, 0x10			//clear bit #4 of the IFS0 reg
    sw t1, 0(t0)
    
    main_loop:
	la t0, PORTACLR		//clear all the bits in port a
	li t1, 0xff
	sw t1, 0(t0)
	
	la t0, PORTASET
	li t1, 0xa5		//part 1, 3)b)i.
	sw t1, 0(t0)

	li a0, 62500		//ii.
	jal timer1_delay_a
	nop
	
	li a0, 62500		//ii.
	jal timer1_delay_a
	nop
	
	li a0, 62500		//ii.
	jal timer1_delay_a
	nop
	
	li a0, 62500		//ii.
	jal timer1_delay_a
	nop
	
	la t0, PORTACLR		//clear all the bits in port a
	li t1, 0xff
	sw t1, 0(t0)

	la t0, PORTASET
	li t1, 0x5a		//part 1, 3)b)iii.
	sw t1, 0(t0)

	li a0, 62500		//ii.
	jal timer1_delay_a
	nop
	
	li a0, 62500		//ii.
	jal timer1_delay_a
	nop
	
	li a0, 62500		//ii.
	jal timer1_delay_a
	nop
	
	li a0, 62500		//ii.
	jal timer1_delay_a
	nop

    j main_loop			//continuous loop
    nop
    
.end main
	

.ent timer1_delay_a
timer1_delay_a:
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
    
.end timer1_delay_a
