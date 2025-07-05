//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 1
//   Project: Intro to DE1-SoC board 
//   File Name: Lab1.v
//   List of other files used: adder.v, segment_7.v
//-----------------------------------------------------------------------------    
//   Description of the Code (1 - 5 lines)
//   The intro to DE1-SoC board Lab takes two 4-bit binary coded decimal inputs 
//		via sliders, on the board, displays each in the seven segment display,
//		adds them & displays their sum in the third seven segment display 
//-----------------------------------------------------------------------------    
//   Date: 01/11/2023
//   Version: 1.0
//-----------------------------------------------------------------------------


module Lab1(
	input [3:0]a,
	input [3:0]b,
	output [6:0]first_ones,
	output [6:0]first_tenths,
	output [6:0]second_ones,
	output [6:0]second_tenths,
	output [6:0]total_ones,
	output [6:0]total_tenths
);


//-----------------------------------------------------------------------------    
//   Signal Declarations: wire
//-----------------------------------------------------------------------------
	wire [4:0]c;
	wire [4:0]first = { 1'b0, a };
	wire [4:0]second = { 1'b0, b };
//-----------------------------------------------------------------------------
	
	
	adder U1(a, b, c);
	
	segment_7 U2(first, first_ones, first_tenths);
	segment_7 U3(second, second_ones, second_tenths);
	segment_7 U4(c, total_ones, total_tenths);
	

endmodule
