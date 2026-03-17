//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 3
//   Project: Multiplexed Display
//   File Name: control.v
//   List of other files used: counter.v, Lab3.v, seg_7.v, bin2bcd.v,
//		back_end.v, decoder.v, mux.v, front_end.v, top_level.v, clk_dv.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this module is the select line for the mux, which will switch between
//		the seven segment displays
//-----------------------------------------------------------------------------    
//   Date: 01/25/2023
//   Version: 1.0
//		Revision: 
//			1/25/2023	- initial version
//			1/28/2023	- comments and file names
//			1/29/2023	- added initial block
//-----------------------------------------------------------------------------


module control(
	input clk,
	input rst,
	output reg [1:0]cntrl
);

initial
	begin
	
		cntrl <= 2'b00;
	
	end

always @(posedge clk or posedge rst)
	begin
	
		if (rst)
			cntrl <= 2'b00;
		else 
			cntrl <= cntrl + 1;
	
	end


endmodule
