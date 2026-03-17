//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 2
//   Project: Intro to Heirarchical Design
//   File Name: decode.v
//   List of other files used: counter.v, Lab2.v, clk_dv.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this module converts a 16 digit BCD# to 5 digits of seven-segment display
//-----------------------------------------------------------------------------    
//   Date: 01/17/2023
//   Version: 1.1
//		Revision: 
//			1/18/2023	- created file, moved this arithmetic to analyze digits
//								from the seg_7 file to here.
//-----------------------------------------------------------------------------


module decode(
	input [15:0]num,
	output reg [3:0]ones,
	output reg [3:0]tens,
	output reg [3:0]hundreds,
	output reg [3:0]thousands,
	output reg [3:0]ten_thousands
);

integer mod_100, mod_1000, mod_10000;


always @(num)
	begin

		ones <= num % 10;
		mod_100 <= num % 100;
		tens <=  mod_100 / 10;  
		mod_1000 <= num % 1000;
		hundreds <= mod_1000 / 100;
		mod_10000 <= num % 10000; 
		thousands <= mod_10000 / 1000;
		ten_thousands <= num / 10000; 

	end

endmodule 