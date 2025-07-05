module FullAdder(
	input a,
	input b,
	input c,
	output carry,
	output sum
);

wire W1, W2, W3;

xor U1(W1, a, b);
xor U2(sum, W1, c);
and U3(W2, c, W1);
and U4(W3, a, b);
or U5(carry, W2, W3);

endmodule