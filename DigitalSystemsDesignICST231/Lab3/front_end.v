//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 3
//   Project: Multiplexed Display
//   File Name: front_end.v
//   List of other files used: counter.v, Lab3.v, seg_7.v, bin2bcd.v,
//		back_end.v, decoder.v, mux.v, control.v, top_level.v, clk_dv.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this module connects all of the display modules together, inverting some
//		of the outputs to their respective proper levels
//-----------------------------------------------------------------------------    
//   Date: 01/25/2023
//   Version: 1.0
//		Revision: 
//			1/25/2023	- initial version
//			1/28/2023	- added comments
//-----------------------------------------------------------------------------


module front_end(
	input [15:0]bcd,
	input clk,
	input rst,
	output [3:0]pin,
	output [6:0]seg_7
);

//-----------------------------------------------------------
// Signal Declarations: wire
//-----------------------------------------------------------
	wire [6:0] ones, tens, hundreds, thousands;
	wire [1:0] control;
	wire clk_2khz;
	

	seg_7 U1(bcd[3:0], ones);
	seg_7 U2(bcd[7:4], tens);
	seg_7 U3(bcd[11:8], hundreds);
	seg_7 U4(bcd[15:12], thousands);
	
	clk_dv U5(clk, rst, clk_2khz);
	
	control U6(clk_2khz, rst, control);
	
	mux U7(control, ones, tens, hundreds, thousands, seg_7);
	
	decoder U8(control, pin);
	


endmodule
