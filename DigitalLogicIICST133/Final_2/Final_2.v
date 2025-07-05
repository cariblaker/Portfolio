//and this puts them both together to see them working at the same time in a simulation

module Final_2(
	input updn,
	input m,
	input cen,
	input rst,
	input clk,
	output [2:0]Q

);

	wire [2:0]W1;
	wire [2:0]W2;

	counter c1(updn, m, cen, rst, clk, W1);
	
	counter_2 c2(updn, m, cen, rst, clk, W2);
	
	
	
endmodule
