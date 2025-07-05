//module myBCDAdder(
//	input [3:0]a,
//	input [3:0]b,
//	output [7:0]X
//);
//
//reg sum[7:0];
////wire temp_sum[4:0];
////wire carry;
//
////assign temp_sum = a ^ b;
////assign carry = (a & b) | (b & c) | (a & c);
//
////reg out[7:0];
//
////always @(*)
////	begin
//		//assign {carry, temp_sum} = a + b;
//		sum = (a + b); //{carry, temp_sum};
//		assign X = (sum < 10) ? sum : (sum == 10) ? 8'b00010000 : ( (sum == 11) ? 8'b00010001 : (sum == 12) ? 8'b00010010 : (sum == 13) ? 8'b00010011 : (sum == 14) ? 8'b00010100 : (sum == 15) ? 8'b00010101 : (sum == 16) ? 8'b00010110 : (sum == 17) ? 8'b00010111 : 8'b00011000 );
////		if (sum < 10) //if a + b is 9 or less, the decimal output will = the binary
////			out = {0, 0, sum};
////		else				//otherwise, case:
////			begin
////				case (sum)
////					5'b01010 : out = 8'b00010000;
////					5'b01011 : out = 8'b00010001;
////					5'b01100 : out = 8'b00010010;
////					5'b01101 : out = 8'b00010011;
////					5'b01110 : out = 8'b00010100;
////					5'b01111 : out = 8'b00010101;
////					5'b10000 : out = 8'b00010110;
////					5'b10001 : out = 8'b00010111;
////					5'b10010 : out = 8'b00011000;
////				endcase
////			end //else
////
////		X = out;
//
////	end //always
//
//endmodule