module decoder2x4(
input ena, 
input p, 
input [1:0]a, 
output [3:0]y
);

	wire [3:0] w, x;
	
	assign w[0] = ~a[1] & ~ a[0];
	assign w[1] = ~a[1] & a[0];
	assign w[2] = a[1] & ~a[0];
	assign w[3] = a[1] & a[0];
	
	assign x[0] = p ? ~w[0] : w[0];
	assign x[1] = p ? ~w[1] : w[1];
	assign x[2] = p ? ~w[2] : w[2];
	assign x[3] = p ? ~w[3] : w[3];
	
	assign y[0] = ena ? 1'bz : x[0];
	assign y[1] = ena ? 1'bz : x[1];
	assign y[2] = ena ? 1'bz : x[2];
	assign y[3] = ena ? 1'bz : x[3];
	

		
endmodule
