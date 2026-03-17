//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 3
//   Project: Multiplexed Display
//   File Name: mux.v
//   List of other files used: counter.v, Lab3.v, seg_7.v, bin2bcd.v,
//		back_end.v, decoder.v, control.v, front_end.v, top_level.v, clk_dv.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this module will output the proper seven-segment display number based
//		on the control line input. 
//-----------------------------------------------------------------------------    
//   Date: 01/25/2023
//   Version: 1.0
//		Revision: 
//			1/25/2023	- initial version
//-----------------------------------------------------------------------------



module mux(
	input [1:0]cntrl,
	input [6:0]ones,
	input [6:0]tens,
	input [6:0]hundreds,
	input [6:0]thousands,
	output reg [6:0]seg_7
);


always @(*)
	begin
	
		case(cntrl)
			0 : seg_7 <= ones;
			1 : seg_7 <= tens;
			2 : seg_7 <= hundreds;
			3 : seg_7 <= thousands;
			default : seg_7 <= 7'b1111111;
		endcase
	
	end



endmodule 