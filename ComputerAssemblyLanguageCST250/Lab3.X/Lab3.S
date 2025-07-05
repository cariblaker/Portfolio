


#include <xc.h>
    
.macro PUSH dest
    addiu sp, sp, -4
    sw \dest, 0(sp)
.endm


// macro for POP goes here
.macro POP srce
    lw \srce, 0(sp)
    addiu sp, sp, 4
.endm
    
    
.global m_multiply
.global m_add
.global m_sub
.global main
.data
    
EXPR:	    .word 3
	    .word 4
	    .word 0x80000000 + '+'
	    .word 6
	    .word 0x80000000 + '+'
	    .word 0x80000000 + '='
	    
	    /*.word 0x80000000 + '*'
	    .word 5
	    .word 6
	    .word 0x80000000 + '-'
	    .word 0x80000000 + '+'
	    .word 0x80000000 + '='*/
RESULT:	.word 0
.text
.set noreorder
	    
.ent m_multiply
m_multiply:
//creating m_multiply stack frame
addiu sp, sp, -8  //making room for two things!
sw ra, 4(sp)
sw fp, 0(sp)
sw a0, 0(fp)
sw a1, 4(fp)
addu fp, sp, zero //sets the bottom of our frame
//end of stack frame construction
//x was passed in as a0
//y was passed in as a1

mul v0, a0, a1
//mflo t2
//addu v0, t2, zero  // t2 has result of above multiplication, which we put in v0
addu sp, fp, zero //snap the sp back to the bottom of the frame
lw fp, 0(sp)          //restore the fp of the calling function
lw ra, 4(sp)          //restore the ra of the calling function
addiu sp, sp, 8       //move the stack pointer back to *wherever* it was
jr ra
nop
.end m_multiply
    
    
.ent m_add
m_add:
addiu sp, sp, -8  //making room for two things (ra, fp)
sw ra, 4(sp)
sw fp, 0(sp)
sw a0, 0(fp)      //note: the FP value here is still related to the calling function
sw a1, 4(fp)
addu fp, sp, zero //NOW we change the FP value.
    
//x was passed in as a0
   //y was passed in as a1
add v0, a0, a1// Do the addition of the contents of registers a0 and a1 (arguments coming through a-registers)
// Make sure the addition result goes into register v0
addu sp, fp, zero //snap the sp back to the bottom of the frame
lw fp, 0(sp)          //restore the fp of the calling function
lw ra, 4(sp)          //restore the ra of the calling function
addiu sp, sp, 8       //move the stack pointer back to *wherever* it was
jr ra
nop
.end m_add
    
.ent m_sub
    m_sub:
    addiu sp, sp, -8
    sw ra, 4(sp)
    sw fp, 0(sp)
    sw a0, 0(fp)
    sw a1, 4(fp)
    addu fp, sp, zero
     //x was passed in as a0
       //y was passed in as a1
    sub v0, a0, a1// Do the addition of the contents of registers a0 and a1 (arguments coming through a-registers)
    //addu v0, t2, zero// Make sure the addition result goes into register v0
    addu sp, fp, zero
    lw fp, 0(sp)
    lw ra, 4(sp)
    addiu sp, sp, 8
    jr ra
    nop
    .end m_sub
    
.ent main
main:
//Stack Frame Preamble
//made space for ra, fp, and a0-a3
addiu sp, sp, -24
sw ra, 20(sp)
sw fp, 16(sp)
addu fp, sp, zero   // move fp to sp
//end of preamble;
/* current state of the stack frame
/----------------------/
|          ra          |
/----------------------/
|          fp          |
/----------------------/
|  room for a3         |
/----------------------/
|  room for a2         |
/----------------------/
|  room for a1         |
/----------------------/
|  room for a0         |
/----------------------/
*/
    la s1, EXPR// pull in the pointer to EXPR[i]
loop_top:
    lw t1, 0(s1) //read the current value of EXPR[i] to a register (say s1)
    la t0, MULT_OP
    lw t2, 0(t0)
    BEQ t1, t2, do_a_mult//Check the current value of EXPR[i] a digit or any of the operators by doing the following
// Check if its a MULT_OP - If 'yes' go to do_a_mult
    nop
    la t0, ADD_OP
    lw t2, 0(t0)
    BEQ t1, t2, do_an_add// If not, Check if its a ADD_OP - If 'yes' go to do_an_add
    nop
    la t0, SUB_OP
    lw t2, 0(t0)
    BEQ t1, t2, do_a_sub// If not, Check if its a SUB_OP - If 'yes' go to do_a_sub
    nop
    la t0, EQU_OP
    lw t2, 0(t0)
    BEQ t1, t2, its_equal// If not, Check if its a EQU_OP - If 'yes' go to its_equal
    nop
// if it isn't one of those operators, then it must be a digit.
//if we got here, then EXPR[i] is a digit. Push it onto the stack
    lw t4, 0(s1)
PUSH t4
j next_thing
nop
do_a_mult:
POP a0
POP a1
jal m_multiply
nop
PUSH v0
j next_thing
nop
do_an_add:
POP a0
POP a1
jal m_add
nop
PUSH v0
j next_thing
nop
do_a_sub:
POP a0
POP a1
jal m_sub
nop
PUSH v0
j next_thing
nop
next_thing:
//really, the only thing this function requires is:
addiu s1, s1, 4//pointer arithmetic -> i++ for EXPR[i]
j loop_top
nop
its_equal:
POP t1
la t0, RESULT
sw t1, 0(t0)
endless:
j endless
nop
addu sp, fp, zero
lw ra, 20(sp)
lw fp, 16(sp)
addiu sp, sp, 24
.end main
    
    
MULT_OP:  .word 0x80000000 + '*'
ADD_OP:   .word 0x80000000 + '+'
SUB_OP:   .word 0x80000000 + '-'
EQU_OP:   .word 0x80000000 + '='