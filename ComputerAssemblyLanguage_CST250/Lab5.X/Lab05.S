#include <xc.h>
    
#ifndef _LAB_05_DEFINES_H
#define _LAB_05_DEFINES_H
  
#define count_total 56(fp)
#define count_9 52(fp)
#define count_8 48(fp)
#define count_7 44(fp)
#define count_6 40(fp)
#define count_5 36(fp)
#define count_4 32(fp)
#define count_3 28(fp)
#define count_2 24(fp)
#define count_1 20(fp)
#define count_0 16(fp)
    
#endif 
    
    
//push macro    
.macro PUSH dest
    addiu sp, sp, -4
    sw \dest, 0(sp)
.endm


//pop macro
.macro POP srce
    lw \srce, 0(sp)
    addiu sp, sp, 4
.endm




.global main
.data
    buff: .byte 0,0,0,0,0,0,0,0,0,0,0
    
.text
    
.ent is_a_digit
    is_a_digit:
    addiu sp, sp, -8
    sw ra, 4(sp)
    sw fp, 0(sp)
    sw a0, 8(sp) //inbount a0 parameter, stored in calling function's stack frame
    addu fp, sp, zero
    
    //value was passed in a0
    lw t0, 8(sp)
    blt t0, 0x30, return_error //if ascii value is less than 0, go to the return error func
    nop
    bgt t0, 0x39, return_error //if ascii value is more than 9, go to the return error func
    nop
    sub v0, t0, 0x30	     //store binary value in return variable v0 if 0 <= x <= 9 <--{x-30 = binary value}
    j done	    //jumps back to where it left off in main
    nop
    
    return_error:
    li v0, 0xffffffff	     //if character is not a digit, return -1 as error
   
    done:
    addu sp, fp, zero
    lw ra, 4(sp)
    lw fp, 0(sp)
    addiu sp, sp, 8
    jr ra 
    nop
    
.end is_a_digit
    
    
.ent output_string
output_string:
    //called function stack frame
    addiu sp, sp, -8
    sw ra, 4(sp)
    sw fp, 0(sp)
    sw a0, 8(sp) //inbount a0 parameter, stored in calling function's stack frame
    addu fp, sp, zero
get_byte:
  lb s0, 0(a0)
  beq s0, zero, string_done
  nop
send:
  // send TX data
  la s2, U1TXREG
  sw s0, 0(s2)
  la s2, U1STA
wait_tx:
  lw s1, 0(s2)
  andi s1, s1, 0x100
  beq s1, zero, wait_tx
  nop
next:
  addu a0, a0, 1
  j get_byte
  nop
string_done:
    //called function stack frame wind-up
    addu sp, fp, zero
    lw ra, 4(sp)
    lw fp, 0(sp)
    addiu sp, sp, 8
    //now we've restored all we need; time to go
    jr ra
    nop
.end output_string
	
	
.ent binary_to_asciidec
binary_to_asciidec:
    //made space for ra, fp, and a0-a3, plus 11 characters of the buffer array
    addiu sp, sp, -8   //room for ra, fp 
    sw fp, 0(sp)
    sw ra, 4(sp)
    sw a0, 8(sp)
    addu fp, sp, zero   // move fp to sp
    
    lw t0, 8(sp)	//a0 = t0
    
    la t1, buff		//t1 is the address of the buffer. t2 is be the address of the count of the number we're on. t3 will be 10.
    li t3, 10	    //put 10 in register t3
    
    lb t2, 0(t1)    //t2 now has first byte of a0 = value we're converting
    
    li t5, 0x30	    //ascii 0
    li t6, 0x00	    //hex null
    
    beqz t0, zero_case	//if t0 is 0, we can just make that ascii and be done.
    nop
    
    div_loop:	    
    divu t0, t3	    //divide our number by 10
    mfhi t4	    //remainder in t4
    addu t4, t4, t5	//convert remainder to ascii 
    PUSH t4
    bne zero, t0, div_loop	//if the quotient is 0, we've reached the end
    nop
    j convert_done
    nop
    
    
    zero_case:
    sb t5, 0(t2)    //stores 0 in current byte of buffer array
    sb t6, 1(t2)    //and null terminator
    sw t2, 0(t1)
    
    
    convert_done:
    POP t4
    sb t4, 0(t2)
    bne t4, t6, convert_done
    sw t2, 0(t1)
 
    
    finally_done:
			    //get rid o' the stack
    addu sp, fp, zero	 //snap the sp back to the bottom of the frame
    lw ra, 4(sp)          //restore the ra of the calling function
    lw fp, 0(sp)          //restore the fp of the calling function
    addiu sp, sp, 8
    jr ra
    nop
    
.end binary_to_asciidec
    
    
.set noreorder
// text segment for instructions and CONSTANT READ-ONLY data follows here
// stored in non-volatile flash memory
.ent main

main:
    //Stack Frame Preamble
    //made space for ra, fp, and a0-a3
    addiu sp, sp, -68
    sw ra, 64(sp)
    sw fp, 60(sp)
    addu fp, sp, zero   // move fp to sp
    
    //////////////////////////////////////////////////////////////
    // configure UART TX
    la t9, U1MODESET
    li t0,0x8000
    sw t0, 0(t9)
    la t9, U1STASET
    li t0, 0x1400
    sw t0, 0(t9)
    ////////////////////////////////////////////////////////////// 
    
    // Clearing out all counts
    sw zero, count_total
    sw zero, count_9
    sw zero, count_8
    sw zero, count_7
    sw zero, count_6
    sw zero, count_5
    sw zero, count_4
    sw zero, count_3
    sw zero, count_2
    sw zero, count_1
    sw zero, count_0
    
    // Load up EXPR 
    la s0, EXPR
    
    parsing_EXPR_loop:
    lb a0, 0(s0) // Load current element of EXPR
    
    // Check for null terminator
    beqz a0, display_string	    //if it IS the null terminator, we're done parsing and we cut to display
    nop
    
    // we're here if it's NOT null, so we check if it's a digit by calling is_a_digit function	    
    jal is_a_digit
    nop
    
    //now we need to check if it was a digit or not--and if it was, add to our totals:

    //if it WAS a digit,  we need to get to store_value
    beq v0, 0xFFFFFFFF, parsing_EXPR_loop  //if v0 is >=0, then we have a digit! so we'll branch and link this spot to come back to so we can parse
    //even if it wasn't a digit, we'll still get to here, where we increment & parse
    addiu s0, s0, 1	    //increment t0 to continue parsing expression

    
 
	
    //MORE TODO HERE --> add the totals, store
    store_value:
	li t1, 1	
	lw t2, count_total
	add t2, t2, t1	//count_total gets one more no matter what number
	sw t2, count_total
	beq v0, 0, store_0
	nop
	beq v0, 1, store_1
	nop
	beq v0, 2, store_2
	nop
	beq v0, 3, store_3
	nop
	beq v0, 4, store_4
	nop
	beq v0, 5, store_5
	nop
	beq v0, 6, store_6
	nop
	beq v0, 7, store_7
	nop
	beq v0, 8, store_8
	nop
	beq v0, 9, store_9
	nop
    store_0:
	lw t2, count_0
	addi t2, t2, 1
	sw t2, count_0
	j parsing_EXPR_loop
	nop
    store_1:
	lw t2, count_1
	addi t2, t2, 1
	sw t2, count_1
	j parsing_EXPR_loop
	nop
    store_2:
	lw t2, count_2
	addi t2, t2, 1
	sw t2, count_2
	j parsing_EXPR_loop
	nop
    store_3:
	lw t2, count_3
	addi t2, t2, 1
	sw t2, count_3
	j parsing_EXPR_loop
	nop
    store_4:
	lw t2, count_4
	addi t2, t2, 1
	sw t2, count_4
	j parsing_EXPR_loop
	nop
    store_5:
	lw t2, count_5
	addi t2, t2, 1
	sw t2, count_5
	j parsing_EXPR_loop
	nop
    store_6:
	lw t2, count_6
	addi t2, t2, 1
	sw t2, count_6
	j parsing_EXPR_loop
	nop
    store_7:
	lw t2, count_7
	addi t2, t2, 1
	sw t2, count_7
	j parsing_EXPR_loop
	nop
    store_8:
	lw t2, count_8
	addi t2, t2, 1
	sw t2, count_8
	j parsing_EXPR_loop
	nop
    store_9:
	lw t2, count_9
	addi t2, t2, 1
	sw t2, count_9
	j parsing_EXPR_loop
	nop
    
    
    display_string:
    // Here we output to UART console   
    la a0, ZEROES	//then the "how many 0s" string
    jal output_string	//outputs 0 string
    nop
    lw a0, count_0			    
    jal binary_to_asciidec	    //this is where binary_to_asciidec needs to be called to convert the binary value, then output_string needs to be called again to output it
    nop
    add a0, v0, zero			    //loads what b_to_a returned in v0 back into a0...
    jal output_string		//to send to output string again.
    nop
    la a0, CR
    jal output_string
    nop
    
    la a0, ONES
    jal output_string		//outputs 1 string
    nop
    lw a0, count_1
    jal binary_to_asciidec
    nop
    add a0, v0, zero			//loads what b_to_a returned in v0 back into a0...
    jal output_string		//to send to output string again.
    nop
    la a0, CR			//then we need a newwwww line
    jal output_string
    nop
    
    la a0, TWOS
    jal output_string	
    nop
    lw a0, count_2			    
    jal binary_to_asciidec	    //this is where binary_to_asciidec needs to be called to convert the binary value, then output_string needs to be called again to output it
    nop
    add a0, v0, zero			    //loads what b_to_a returned in v0 back into a0...
    jal output_string		//to send to output string again.
    nop
    la a0, CR
    jal output_string
    nop
    
    la a0, THREES
    jal output_string	
    nop
    lw a0, count_3			    
    jal binary_to_asciidec	    //this is where binary_to_asciidec needs to be called to convert the binary value, then output_string needs to be called again to output it
    nop
    add a0, v0, zero			    //loads what b_to_a returned in v0 back into a0...
    jal output_string		//to send to output string again.
    nop
    la a0, CR
    jal output_string
    nop
    
    la a0, FOURS
    jal output_string	
    nop
    lw a0, count_4			    
    jal binary_to_asciidec	    //this is where binary_to_asciidec needs to be called to convert the binary value, then output_string needs to be called again to output it
    nop
    add a0, v0, zero			    //loads what b_to_a returned in v0 back into a0...
    jal output_string		//to send to output string again.
    nop
    la a0, CR
    jal output_string
    nop
    
    la a0, FIVES
    jal output_string	
    nop
    lw a0, count_5			    
    jal binary_to_asciidec	    //this is where binary_to_asciidec needs to be called to convert the binary value, then output_string needs to be called again to output it
    nop
    add a0, v0, zero			    //loads what b_to_a returned in v0 back into a0...
    jal output_string		//to send to output string again.
    nop
    la a0, CR
    jal output_string
    nop
    
    la a0, SIXES
    jal output_string	
    nop
    lw a0, count_6			    
    jal binary_to_asciidec	    //this is where binary_to_asciidec needs to be called to convert the binary value, then output_string needs to be called again to output it
    nop
    add a0, v0, zero			    //loads what b_to_a returned in v0 back into a0...
    jal output_string		//to send to output string again.
    nop
    la a0, CR
    jal output_string
    nop
    
    la a0, SEVENS
    jal output_string	
    nop
    lw a0, count_7			    
    jal binary_to_asciidec	    //this is where binary_to_asciidec needs to be called to convert the binary value, then output_string needs to be called again to output it
    nop
    add a0, v0, zero			    //loads what b_to_a returned in v0 back into a0...
    jal output_string
    nop
    la a0, CR
    jal output_string
    nop
    
    la a0, EIGHTS
    jal output_string	
    nop
    lw a0, count_8			    
    jal binary_to_asciidec	    //this is where binary_to_asciidec needs to be called to convert the binary value, then output_string needs to be called again to output it
    nop
    add a0, v0, zero		    //loads what b_to_a returned in v0 back into a0...
    jal output_string
    nop
    la a0, CR
    jal output_string		//to send to output string again.
    nop
    
    la a0, NINES
    jal output_string	
    nop
    lw a0, count_9	
    jal binary_to_asciidec
    nop
    add a0, v0, zero
    jal output_string	    //this is where binary_to_asciidec needs to be called to convert the binary value, then output_string needs to be called again to output it
    nop
    la a0, CR			    //loads what b_to_a returned in v0 back into a0...	    <<<<<------does the carriage return need to be sent to the b_to_a func too???????
    jal output_string		//to send to output string again.
    nop
    
    la a0, T_NUM
    jal output_string
    nop
    lw a0, count_total
    jal binary_to_asciidec
    nop 
    add a0, v0, zero
    jal output_string
    nop
    
    
    addu sp, fp, zero
    lw ra, 64(sp)
    lw fp, 60(sp)
    addiu sp, sp, 68
.end main
    
// constants go here
EXPR:	.asciiz "There are 10 kinds of people in the world, those who understand binary and those who don't. The rest of the 0-9 digits are 2, 3, 4, 5, 6, 7, 8, 9."
CR:	.asciiz "\r\n"
T_NUM:	.asciiz "Total number of digits: "
ZEROES:	.asciiz "Total number of 0s: "
ONES:	.asciiz "Total number of 1s: "
TWOS:	.asciiz "Total number of 2s: "
THREES:	.asciiz "Total number of 3s: "
FOURS:	.asciiz "Total number of 4s: "
FIVES:	.asciiz "Total number of 5s: "
SIXES:	.asciiz "Total number of 6s: "
SEVENS:	.asciiz "Total number of 7s: "
EIGHTS:	.asciiz "Total number of 8s: "
NINES:	.asciiz "Total number of 9s: "

    


    
    