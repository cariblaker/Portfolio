module HalfAdder(
	input a,
	input b,
	output carry,
	output sum
);


wire W1, W2, W3, W4;

not U1(W1, a);
not U2(W2, b);
and U3(W3, W1, b);
and U4(W4, W2, a);
and U5(carry, a, b);
or U6(sum, W3, W4);


endmodule