module mux2_1b (
	input a,
	input b,
	input sel,
	output x
);


	wire W1, W2, W3;

	not U1(W1, sel);
	and U2(W2, a, W1);
	and U3(W3, b, sel);
	or U4(x, W2, W3);
	
	//mux2_1	M1(a, b, sel, W1);
	//mux2_1	M2(



endmodule