module shifter(
	input sin,
	input [3:0]A,
	input [1:0]sel,
	output reg [3:0]Y

);



	always @(sel)
	begin
	
		case (sel)
		
			2'b00:	Y <= A;
			2'b01:	Y <= {A[2:0], 1'b0};
			2'b10:	Y <= {sin, A[3:1]};
			2'b11:	Y <= 4'b0000;
		
		endcase
	
	
	end





endmodule 