////////////////////////////////////////////////////////////////////////////////
// File:	isr_timer32.S
// Author:	Cari Blaker
////////////////////////////////////////////////////////////////////////////////
    
#include <xc.h>	 

.global isr_timer32
.text
.set noreorder

.ent isr_timer32
    isr_timer32:
	// Prologue
	// Note: Upon entry, interrupts are DISABLED! (via ERL or EXL)
	rdpgpr sp, sp
	addiu sp, sp, -76	    // Allocate necessary stack space*
	mfc0 k1, _CP0_EPC	    // Read EPC Register into k1
	sw k1, 0(sp)		    // Push *1* EPC Register contents
	mfc0 k1, _CP0_STATUS	    // Read Status Register into k1
	sw k1, 4(sp)		    // Push *2* Status Register contents
	mfc0 k0, _CP0_CAUSE	    // Read Cause Register into k0
	srl k0, k0, 10		    // Align RIPL to bit 0
	ins k1, k0, 10, 6	    // Set priority threshold
	ins k1, zero, 1, 4	    // UM = 0; ERL = 0; EXL = 0
	mtc0 k1, _CP0_STATUS	    // Reenable INTs!
	sw fp, 8(sp)		    // Push *n* as necessary
	addu fp, sp, zero	    // move fp to sp
	sw a0, 12(fp)
	sw a1, 16(fp)
	sw a2, 20(fp)
	sw a3, 24(fp)
	sw v0, 28(fp)
	sw v1, 32(fp)
	sw t0, 36(fp)
	sw t1, 40(fp)
	sw t2, 44(fp)
	sw t3, 48(fp)
	sw t4, 52(fp)
	sw t5, 56(fp)
	sw t6, 60(fp)
	sw t7, 64(fp)
	sw t8, 68(fp)
	sw t9, 72(fp)

	la t0, T2CONCLR			    //stop timer 2
	li t1, 0x8000
	sw t1, 0(t0)
	
	la t0, IFS0CLR			    //clear T3IF = bit 12 of IFS0
	li t1, 0x1000			    // 0001 0000 0000 0000
	sw t1, 0(t0)
	
	la t0, FLASHER			    //check flasher. if 0, clear RA6. if 1, do other stuff	    
	lw t0, 0(t0)
	beqz t0, flasher_zero
	nop
	
	la t0, PORTAINV				    //flasher is not zero here. so toggle ra6, clear tmr2, load pr2 = 625000 & start timer2
	li t1, 0x0040				    //bit 6 of PORTA = RA6 so 0000 0000 0100 0000
	sw t1, 0(t0)
	
	la t0, TMR2
	li t1, 0x0
	sw t1, 0(t0)
	
	la t0, PR2
	li t1, 625000				    
	sw t1, 0(t0)
	
	la t0, T2CONSET				    //<<<<---------hopefully timer 2 is exactly the same as timer1 but with a 2
	li t1, 0x8000
	sw t1, 0(t0)
	
	j skip_zero
	nop
	
	flasher_zero:
	    la t0, PORTACLR			    //this is where RA6 is cleared because FLASHER was 0
	    li t0, 0x0040
	    sw t1, 0(t0)
    
	skip_zero:				    //both code paths land here				    
	
	
	// Epilogue
	lw t9, 72(fp)		    // Restore as necessary
	lw t8, 68(fp)
	lw t7, 64(fp)
	lw t6, 60(fp)
	lw t5, 56(fp)
	lw t4, 52(fp)
	lw t3, 48(fp)
	lw t2, 44(fp)
	lw t1, 40(fp)
	lw t0, 36(fp)
	lw v1, 32(fp)
	lw v0, 28(fp)
	lw a3, 24(fp)
	lw a2, 20(fp)
	lw a1, 16(fp)
	lw a0, 12(fp)
	addu fp, sp, zero	    // move fp to sp // Restore registers
	lw fp, 8(sp)
	di			    // Disable interrupts
	lw k0, 0(sp)		    // Pop EPC Register contents into k0
	mtc0 k0, _CP0_EPC	    // Restore EPC Register contents
	lw k0, 4(sp)		    // Pop Status Register contents into k0
	mtc0 k0, _CP0_STATUS	    // Restore Status Register contents
	addiu sp, sp, 76	    // Deallocate stack space as necessary*
	eret			    // return from exception
				    // no ?nop? required after eret!
				    // eret will reenable interrupts
	jr ra
	nop


.end isr_timer32
	
    .section .vector_12, code
	    j isr_timer32
	    nop
	    