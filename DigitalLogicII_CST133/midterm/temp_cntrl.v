module temp_cntrl(
	input c1,
	input c2,
	input c3,
	output heat,
	output cool
);


	wire W1, W2;
	
	and U1(W1, c1, c3);
	and U2(W2, c1, ~c2);
	
	or U3(cool, W1, W2);
	
	not U4(heat, c1);
	


endmodule