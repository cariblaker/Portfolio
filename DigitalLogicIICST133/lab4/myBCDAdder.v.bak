module myBCDAdder(
	input [3:0]a,
	input [3:0]b,
	output [7:0]X;
);

reg sum[5:0];

always @(*)
	begin
		sum = a + b;
		if (sum < 10) //if a + b is 9 or less, the decimal output will = the binary
			X = {0, 0, sum};
		else				//otherwise, case:
			begin
				case (sum)
					5'b01010 : X = 8'b00010000;
					5'b01011 : X = 8'b00010001;
					5'b01100 : X = 8'b00010010;
					5'b01101 : X = 8'b00010011;
					5'b01110 : X = 8'b00010100;
					5'b01111 : X = 8'b00010101;
					5'b10000 : X = 8'b00010110;
					5'b10001 : X = 8'b00010111;
					5'b10010 : X = 8'b00011000;
				endcase
			end //else



	end //always

endmodule