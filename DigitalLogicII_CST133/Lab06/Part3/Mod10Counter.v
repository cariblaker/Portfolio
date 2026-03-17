module Mod10Counter(
	input up_dn,
	input cen,
	input clk,
	input reset,
	output [6:0]out
);

	wire [3:0]W1;

	myMOD10Counter U1(up_dn, cen, clk, reset, W1);
	myBCDDecoder U2(W1, out);


endmodule
