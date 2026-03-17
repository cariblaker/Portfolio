//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 6
//   Project: UART receiver
//   File Name: seg_7.v
//   List of other files used: clk_dv.v, UART_rx.v, Lab6.v, UART_tx.v,
//											flag_x_domain
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this module converts a 4 digit BCD# to one digit of seven-segment display
//		in hex
//-----------------------------------------------------------------------------    
//   Date: 3/8/2023
//   Version: 1.2
//		Revision: 
//			3/8/23	- initial version
//-----------------------------------------------------------------------------


module seg_7(
	input [4:0]num,
	input rst,
	output reg [6:0]display
);


always @(num)
	begin
		if (rst)
			begin
				display = 7'b1111111;
			end
			
		else
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
					14:	display = 7'b0000110; 
					15:	display = 7'b0001110; 
					default display = 7'b1111111;					//segment should be completely off if no number to display
				endcase
			end
		
	end

endmodule
