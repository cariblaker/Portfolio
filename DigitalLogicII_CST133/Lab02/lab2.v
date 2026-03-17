module lab2(
	input [3:0]a,
	input [3:0]b,
	input sel,
	output [3:0]y
);

	
	mux2_1b	M1(a, b, sel, y[0]);
	mux2_1b	M2(a, b, sel, y[1]);
	mux2_1b	M3(a, b, sel, y[2]);
	mux2_1b	M4(a, b, sel, y[3]);


endmodule
