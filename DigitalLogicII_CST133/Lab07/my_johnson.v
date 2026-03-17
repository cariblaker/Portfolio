module my_johnson(
	input cen,
	input ud,
	input rst,
	input clk,
	output [6:0]lil_digit,
	output [6:0]big_digit
);

	wire [4:0]Q;
	
	johnson U1(cen, ud, rst, clk, Q);
	JohnsontoSevenSeg U2(Q, lil_digit, big_digit);




endmodule
