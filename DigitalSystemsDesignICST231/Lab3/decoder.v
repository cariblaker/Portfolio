//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 3
//   Project: Multiplexed Display
//   File Name: decoder.v
//   List of other files used: counter.v, Lab3.v, seg_7.v, bin2bcd.v,
//		back_end.v, mux.v, control.v, front_end.v, top_level.v, clk_dv.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this module decodes the control input to activate the proper pin....
//		it's coded for active high.
//-----------------------------------------------------------------------------    
//   Date: 01/25/2023
//   Version: 1.0
//		Revision: 
//			1/25/2023	- initial version
//			1/28/2023	- added file definition
//-----------------------------------------------------------------------------



module decoder(
	input [1:0]cntrl,
	output reg [3:0]pin
);

always @(cntrl)
	begin

		case (cntrl)
			0 : pin <= 4'b1110;   
			1 : pin <= 4'b1101;
			2 : pin <= 4'b1011;
			3 : pin <= 4'b0111;
			default : pin <= 4'b1111;
		endcase

	end	


endmodule

