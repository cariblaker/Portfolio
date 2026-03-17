////////////////////////////////////////////////////////////////////////////////
// File:	lab4i.S
// Author:	Cari Blaker
////////////////////////////////////////////////////////////////////////////////
    
#include <xc.h>
    
.global main
.global instr_delay
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
    
    main_loop:
	la t0, PORTACLR		//clear all the bits in port a
	li t1, 0xff
	sw t1, 0(t0)
	
	la t0, PORTASET
	li t1, 0xa5		//part 1, 3)b)i.
	sw t1, 0(t0)

	li a0, 62500		//ii.
	jal instr_delay
	nop
	
	la t0, PORTACLR		//clear all the bits in port a
	li t1, 0xff
	sw t1, 0(t0)

	la t0, PORTASET
	li t1, 0x5a		//part 1, 3)b)iii.
	sw t1, 0(t0)

	li a0, 62500		//iv.
	jal instr_delay
	nop

    j main_loop			//continuous loop
    nop
    
.end main
	

.ent instr_delay
instr_delay:
    //Stack Frame Preamble
    //made space for ra, fp, and a0-a3
    addiu sp, sp, -68
    sw ra, 64(sp)
    sw fp, 60(sp)
    addu fp, sp, zero   // move fp to sp
    
    delay_loop:			//3) a) again (the second 3a)
	nop			//don't know why this is necessary?
	addi a0, a0, -1
	bne a0, zero, delay_loop
	nop
    
    //de-stackification
    addu sp, fp, zero
    lw ra, 64(sp)
    lw fp, 60(sp)
    addiu sp, sp, 68
    
    jr ra
    nop
    
.end instr_delay

