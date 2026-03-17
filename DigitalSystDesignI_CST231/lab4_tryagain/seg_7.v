//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 4
//   Project: Digital Lock
//   File Name: seg_7.v
//   List of other files used: clk_dv.v, keypad.v, keypad_decode.v,
//		board_in_out.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this module converts a 4 digit BCD# to one digit of seven-segment display
//-----------------------------------------------------------------------------    
//   Date: 2/2/2023
//   Version: 1.2
//		Revision: 
//			2/1/23	- initial version
//-----------------------------------------------------------------------------


module seg_7(
	input [3:0]num,
	output reg [6:0]display
);


always @(num)
	begin
	
		case (num)
			0 : 	display = 7'b1000000;
			1 :	display = 7'b1111001;
			2 :	display = 7'b0100100;
			3 :	display = 7'b0110000;
			4 :	display = 7'b0011001;
			5 :	display = 7'b0010010;
			6 :	display = 7'b0000010;
			7 :	display = 7'b1111000;
			8 :	display = 7'b0000000;
			9 :	display = 7'b0010000;
			10:	display = 7'b0001000;
			11:	display = 7'b0000011;
			12:	display = 7'b1000110;
			13:	display = 7'b0100001;
			default display = 7'b1111111;					//segment should be completely off if no number to display
		endcase
	
		
	end

endmodule
