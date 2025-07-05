module BinaryCounter(
	input [3:0]D,
	input up_dn,
	input clk,
	input reset,
	input load,
	output [6:0] out
);


	wire [3:0]W1;

	myCounter U1(clk, D, up_dn, reset, load, W1);
	myDecoder U2(W1, out);


endmodule
