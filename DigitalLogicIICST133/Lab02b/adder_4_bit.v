module adder_4_bit(
	input [3:0]a,
	input [3:0]b,
	//output [2:0]carry,
	output [3:0]sum,
	output cout
); 

wire W1, W2, W3;

HalfAdder M0(a[0], b[0], W1, sum[0]);
FullAdder M1(a[1], b[1], W1, W2, sum[1]);
FullAdder M2(a[2], b[2], W2, W3, sum[2]);
FullAdder M3(a[3], b[3], W3, sum[3], cout);

endmodule