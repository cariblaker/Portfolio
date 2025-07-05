//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 1
//   Project: Intro to DE1-SoC board 
//   File Name: adder.v
//   List of other files used: Lab1.v, segment_7.v
//-----------------------------------------------------------------------------    
//   Description of the code:
//		the adder takes two input numbers, adds them together, and outputs
//		their sum.
//-----------------------------------------------------------------------------    
//   Date: 01/11/2023
//   Version: 1.0
//-----------------------------------------------------------------------------

module adder(
	input [3:0]num1,
	input [3:0]num2,
	output [4:0]total

);


	assign total = num1 + num2;


endmodule
