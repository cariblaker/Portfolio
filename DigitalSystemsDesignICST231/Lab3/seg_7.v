//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 3
//   Project: Multiplexed Display
//   File Name: seg_7.v
//   List of other files used: counter.v, Lab3.v, back_end.v, bin2bcd.v,
//		decoder.v, mux.v, control.v, front_end.v, top_level.v, clk_dv.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this module converts one digit BCD# to one digit of seven-segment display
//		it's now coded for active high with a quick fix
//-----------------------------------------------------------------------------    
//   Date: 01/25/2023
//   Version: 1.2
//		Revision: 
//			1/25/2023	- initial version
//			1/28/2023	-  added comments, easy conevrsion to active high
//-----------------------------------------------------------------------------


module seg_7(
	input [3:0]num,
	output reg [6:0]display
);

reg [6:0]active_low;


always @(num)
	begin
	
		case (num)
			0 : 	active_low = 7'b1000000;
			1 :	active_low = 7'b1111001;
			2 :	active_low = 7'b0100100;
			3 :	active_low = 7'b0110000;
			4 :	active_low = 7'b0011001;
			5 :	active_low = 7'b0010010;
			6 :	active_low = 7'b0000010;
			7 :	active_low = 7'b1111000;
			8 :	active_low = 7'b0000000;
			9 :	active_low = 7'b0010000;
			default active_low = 7'b1111111;
		endcase
		
		display = ~active_low;
		
	end

endmodule
