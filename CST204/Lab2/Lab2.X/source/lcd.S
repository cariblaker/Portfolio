////////////////////////////////////////////////////////////////////////////////
// File:	lcd.S
// Author:	Cari Blaker
////////////////////////////////////////////////////////////////////////////////

#include <xc.h>
.global lcd_read
.global lcd_write
.global lcd_wait_for_not_busy
.global lcd_write_string
.global instr_busy_wait
.global lcd_config
    
.text
.set noreorder
    
.ent lcd_read
lcd_read:
    beqz a0, clrB					//if a0 is 1, set portB bit 15. If a0 is 0, clear portB bit 15
    nop							//this part sets RS properly (selects appropriate register)
    //port B SET bit 15
    la v1, PORTBSET
    li t0, 0x8000
    sw t0, 0(v1)
    j setD						//have to jump past the clearing part since we just set!
    nop
    
    clrB:						//port B clear bit 15
    la v1, PORTBCLR
    li t0, 0x8000
    sw t0, 0(v1)
    
    setD:						//either branch above gets us here
    la v1, PORTDSET					//port D set bit 5 to a 1 for read, and bit 4 to a 1 to enable
    li t0, 0x20
    sw t0, 0(v1)
    la v1, PORTDSET
    li t0, 0x10
    sw t0, 0(v1)
    
    nop							//9 nops for timing delay
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    
    la v1, PORTE					//reads DB7-DB0 & adds 1111 1111 to clear any other garbage out
    lw v0, 0(v1)
    andi v0, v0, 0xff					//value ends up in v0
    
    la v1, PORTDCLR
    li t0, 0x10						//clear the 4th bit of port D (enable = 0)
    sw t0, 0(v1)
    
    jr ra
    nop
.end lcd_read

    
.ent lcd_write
lcd_write:
    la v1, PORTECLR					//first clear RE7 - RE0
    li t0, 0xff
    sw t0, 0(v1)
    la v1, PORTESET					//then set w/ a1 input value
    sw a1, 0(v1)					// <<<<<<<<<<<<<<<<<<----------------------- this right???????????? seems too easy
    
    beqz a0, clrB_write
    nop
    la v1, PORTBSET					//sets PORTB if a0 = 1 (bit 15)
    li t0, 0x8000
    sw t0, 0(v1)
    j set_write_bit					//must jump over if a0 = 0 portion
    nop
    
    clrB_write:
    la v1, PORTBCLR					//clears PORTB if a0 = 0 (bit 15)
    li t0, 0x8000
    sw t0, 0(v1)
    
    set_write_bit:					//both branches land here
    la v1, PORTDCLR
    li t0, 0x20						//clears PORTD bit 5
    sw t0, 0(v1)
    
    la v1, PORTDSET					//sets PORTD bit 4 for enable
    li t0, 0x10
    sw t0, 0(v1)				    
    
    la v1, TRISECLR					//<<<<<<----------- ??????????? I think I got it? #5 in lab under lcd_write. drive RE7 - RE0 port pins to output?
    li t0, 0xff
    sw t0, 0(v1)
    
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    
    la v1, PORTDCLR
    li t0, 0x10
    sw t0, 0(v1)					//disables the enable (portd bit 4 = 0)
    
    la v1, TRISESET					//<<<<<<----------- ??????????? I think I got it? #8 in lab under lcd_write. float RE7 - RE0 port pins to input?
    li t0, 0xff
    sw t0, 0(v1)
    
    jr ra
    nop
.end lcd_write
    
    
.ent lcd_wait_for_not_busy
lcd_wait_for_not_busy:
    //Stack Frame Preamble
    //made space for ra, fp, and a0-a3
    addiu sp, sp, -68
    sw ra, 64(sp)
    sw fp, 60(sp)
    addu fp, sp, zero   // move fp to sp
    li a0, 0				    //want the read function to read the busy flag status, so pass a 0 in a0 before jumping to read func
    jal lcd_read
    nop
    andi t0, v0, 0b10000000		    //clearing everything except MSB for checking
    beqz t0, busy_done			    //if it's a 1, it's still busy, so recursively call this function & re-read
    nop					    //once it's a zero, jump to done and get outta here
    j lcd_wait_for_not_busy
    nop
    
    busy_done:
	addu sp, fp, zero
	lw ra, 64(sp)
	lw fp, 60(sp)
	addiu sp, sp, 68
	jr ra
	nop
	
.end lcd_wait_for_not_busy
    
    
.ent lcd_write_string
lcd_write_string:
    //Stack Frame Preamble
    //made space for ra, fp, and a0-a3
    addiu sp, sp, -68
    sw ra, 64(sp)
    sw fp, 60(sp)
    addu fp, sp, zero   // move fp to sp
    
    jal lcd_wait_for_not_busy
    nop
    lb t0, 0(a0)					//store the value in a0 into a1 so it can be written in lcd_write
    sw t0, 0(a1)
    jal lcd_write 
    nop
    addi a0, 1
    lb t0, 0(a0)
    beq t0, zero, string_done
    nop
    j lcd_write_string
    nop
    string_done:
	addu sp, fp, zero
	lw ra, 64(sp)
	lw fp, 60(sp)
	addiu sp, sp, 68
        jr ra
	nop
    
.end lcd_write_string
	
	
	
.ent instr_busy_wait
instr_busy_wait:
    addi a0, a0, -1
    beqz a0, done
    nop
    j instr_busy_wait
    nop
    done:
	jr ra
	nop
.end instr_busy_wait
	
.ent lcd_config
    //stack frame preamble
    //made space for ra, fp, & a0-a3
    addiu sp, sp, -68
    sw ra, 64(sp)
    sw fp, 60(sp)
    addu fp, sp, zero

    li a0, 200000			    //instr_busy_wait should take 2 nanoseconds, soooo 200,000 to make 40 mS
    jal instr_busy_wait
    nop
    li a0, 0
    li a1, 0x38				    //loads function set (8it interface, 2line display, 5x8 font) command into a1
    jal lcd_write
    nop
    jal lcd_wait_for_not_busy	    	    //waits for scren to be ready
    nop
    li a0, 0
    li a1, 0x06				    //a1 now contains command for set entry mode, increment address, no shift
    jal lcd_write
    nop
    jal lcd_wait_for_not_busy		    //wait for screen to be ready
    nop
    li a0, 0
    li a1, 0x0f
    jal lcd_write			    //a1 now contains command set display mode-on, cursor on, cursor blink
    nop
    jal lcd_wait_for_not_busy		    //wait for screen to be ready
    nop
    li a0, 0
    li a1, 0x80
    jal lcd_write			    //a1 now contains set address = 0
    nop
    jal lcd_wait_for_not_busy		    //wait for screen to be ready
    nop
    li a0, 0
    li a0, 0x01				    //jal lcd_wait_for_not_busy	    
    nop
    li a0, 0
    li a1, 0x80
    jal lcd_write   			    //a1 contains clear display command
    nop
    //stack destruction
    addu sp, fp, zero
    lw ra, 64(sp)
    lw fp, 60(sp)
    addiu sp, sp, 68
.end lcd_config
	
	
    