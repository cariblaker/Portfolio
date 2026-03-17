module Final_1(
	input aload,
	input clk,
	input aclr,
	output [2:0]X 
);

	wire D1, W2, W3;
	wire [2:0]Q;
	
	
	nor U1(W3, Q[0], Q[1]);
	xor U2(W2, Q[1], Q[2]);
	xor U3(D1, W2, W3);

	//D, clk, aload, aclr
	D_FF FF1(D1, clk, aload, aclr, Q[0]);
	D_FF FF2(Q[0], clk, aload, aclr, Q[1]);
	D_FF FF3(Q[1], clk, aload, aclr, Q[2]);
	
	
	assign X[2] = Q[0];
	assign X[1] = Q[1];
	assign X[0] = Q[2];



endmodule 