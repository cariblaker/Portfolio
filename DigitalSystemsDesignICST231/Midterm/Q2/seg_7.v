//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Midterm 2
//   Project: Car Lot Counter
//   File Name: seg_7.v
//   List of other files used: sensor_FSM.v, BCD_ones.v, BCD_tens.v, lot_counter.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this module converts a BCD# to seven-segment display
//-----------------------------------------------------------------------------    
//   Date: 03/02/2023
//   Version: 1.0
//-----------------------------------------------------------------------------


module seg_7(
	input [3:0]num,
	output reg [6:0]display
);


always @(num)
	begin
	
		case (num)
			0 : 	display = 7'b0111111;
			1 :	display = 7'b0000110;
			2 :	display = 7'b1011011;
			3 :	display = 7'b1001111;
			4 :	display = 7'b1100110;
			5 :	display = 7'b1101101;
			6 :	display = 7'b1111101;
			7 :	display = 7'b0000111;
			8 :	display = 7'b1111111;
			9 :	display = 7'b1101111;
			default display = 7'b0000000;
		endcase
		
	end

endmodule
