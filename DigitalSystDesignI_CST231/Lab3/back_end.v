//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 3
//   Project: Multiplexed Display
//   File Name: back_end.v
//   List of other files used: counter.v, Lab3.v, seg_7.v, bin2bcd.v,
//		decoder.v, mux.v, control.v, front_end.v, top_level.v, clk_dv.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this module connects the proper clock speed to the counter and the same
//		clock speed to decode the counted number in the bcd converter
//-----------------------------------------------------------------------------    
//   Date: 01/25/2023
//   Version: 1.0
//		Revision: 
//			1/25/2023	- initial design
//			1/28/2023	- added file definition
//-----------------------------------------------------------------------------


module back_end
#(parameter BIT_COUNT = 12)(
	input clk,
	input updn,
	input rst,
	input ena,
	output wire [BIT_COUNT + (BIT_COUNT - 4)/3 : 0] bcd
);

//-----------------------------------------------------------
// Signal Declarations: wire
//-----------------------------------------------------------
	wire clk_2hz;
	wire [BIT_COUNT - 1 :0]cnt;

	
	clk_dv #(12500 )U1(clk, rst, clk_2hz);
	
	counter U2(clk_2hz, updn, rst, ena, cnt);
	
	bin2bcd #(12)U3(cnt, bcd);


endmodule
