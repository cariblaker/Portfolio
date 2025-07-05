//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 3
//   Project: Multiplexed Display
//   File Name: front_end.v
//   List of other files used: counter.v, Lab3.v, seg_7.v, bin2bcd.v,
//		back_end.v, decoder.v, mux.v, control.v, front_end.v, clk_dv.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this module connects the counter logic (back end)  and display logic 
//		(front end) together, creating the top level design
//-----------------------------------------------------------------------------    
//   Date: 01/25/2023
//   Version: 1.0
//		Revision: 
//			1/25/2023	- initial version
//			1/28/2023	- added comments and file names
//-----------------------------------------------------------------------------

module top_level
#(parameter BIT_COUNT = 12)(
	input clock,
	input updn,
	input reset,
	input enable,
	output wire [6:0]seg_7,
	output wire [3:0]pin 
);


//-----------------------------------------------------------
// Signal Declarations: wire
//-----------------------------------------------------------

	wire [15 : 0] bcd;
	

	back_end #(12)U1(clock, updn, reset, enable, bcd);
	
	front_end U2(bcd, clock, reset, pin, seg_7);


endmodule


