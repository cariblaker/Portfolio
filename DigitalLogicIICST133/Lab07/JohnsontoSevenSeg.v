module JohnsontoSevenSeg(
	input [4:0]Q,
	output reg [6:0]lil_digit,
	output reg [6:0]big_digit
);


	always @(*)
	begin
	
		case(Q)
			5'b00000 :	begin lil_digit <= 7'b1000000;
									big_digit <= 7'b1000000;
							end
			5'b00001 :	begin	lil_digit <= 7'b1111001;
									big_digit <= 7'b1000000;
							end
			5'b00010 :	begin	lil_digit <= 7'b0100100;
									big_digit <= 7'b1000000;
							end
			5'b00011 :	begin	lil_digit <= 7'b0110000;
									big_digit <= 7'b1000000;
							end
			5'b00100 :	begin	lil_digit <= 7'b0011001;
									big_digit <= 7'b1000000;
							end
			5'b00101 :	begin	lil_digit <= 7'b0010010;
									big_digit <= 7'b1000000;
							end
			5'b00110 :	begin	lil_digit <= 7'b0000010;
									big_digit <= 7'b1000000;
							end
			5'b00111 :  begin	lil_digit <= 7'b1111000;
									big_digit <= 7'b1000000;
							end
			5'b01000 :  begin	lil_digit <= 7'b0000000;
									big_digit <= 7'b1000000;
							end
			5'b01001 :	begin	lil_digit <= 7'b0010000;
									big_digit <= 7'b1000000;
							end
			5'b01010 :	begin	lil_digit <= 7'b0001000;
									big_digit <= 7'b1000000;
							end
			5'b01011 :	begin lil_digit <= 7'b0000011;
									big_digit <= 7'b1000000;
							end
			5'b01100 :	begin lil_digit <= 7'b1000110;
									big_digit <= 7'b1000000;
							end
			5'b01101 :  begin lil_digit <= 7'b0100001;
									big_digit <= 7'b1000000;
							end
			5'b01110 :  begin lil_digit <= 7'b0000110;
									big_digit <= 7'b1000000;
							end
			5'b01111 :  begin lil_digit <= 7'b0001110;
									big_digit <= 7'b1000000;
							end
							
							
							
			5'b10000 :  begin lil_digit <= 7'b1000000;
									big_digit <= 7'b1111001;
							end
			5'b10001 :  begin lil_digit <= 7'b1111001;
									big_digit <= 7'b1111001;
							end
			5'b10010 :  begin lil_digit <= 7'b0100100;
									big_digit <= 7'b1111001;
							end	
			5'b10011 :	begin	lil_digit <= 7'b0110000;
									big_digit <= 7'b1111001;
							end
			5'b10100 :	begin	lil_digit <= 7'b0011001;
									big_digit <= 7'b1111001;
							end
			5'b10101 :	begin	lil_digit <= 7'b0010010;
									big_digit <= 7'b1111001;
							end
			5'b10110 :	begin	lil_digit <= 7'b0000010;
									big_digit <= 7'b1111001;
							end
			5'b10111 :  begin	lil_digit <= 7'b1111000;
									big_digit <= 7'b1111001;
							end
			5'b11000 :  begin	lil_digit <= 7'b0000000;
									big_digit <= 7'b1111001;
							end
			5'b11001 :	begin	lil_digit <= 7'b0010000;
									big_digit <= 7'b1111001;
							end
			5'b11010 :	begin	lil_digit <= 7'b0001000;
									big_digit <= 7'b1111001;
							end
			5'b11011 :	begin lil_digit <= 7'b0000011;
									big_digit <= 7'b1111001;
							end
			5'b11100 :	begin lil_digit <= 7'b1000110;
									big_digit <= 7'b1111001;
							end
			5'b11101 :  begin lil_digit <= 7'b0100001;
									big_digit <= 7'b1111001;
							end
			5'b11110 :  begin lil_digit <= 7'b0000110;
									big_digit <= 7'b1111001;
							end
			5'b11111 :  begin lil_digit <= 7'b0001110;
									big_digit <= 7'b1111001;
							end
							
			default : 	begin lil_digit <= 7'b1000000;
									big_digit <= 7'b1000000;
							end
					
			endcase
	
	
	
	end



endmodule 