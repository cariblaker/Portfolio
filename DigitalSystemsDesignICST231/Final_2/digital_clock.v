


module digital_clock(
	input clk, reset,
	input set, hour, minute, //[3:0]KEY,
	output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0,
	output ampm
);


	wire clk_1khz, clk_1hz;
	wire [3:0] hours;
	wire [5:0] minutes, seconds;

	clk_dv #(25000000) 	U1(clk, clk_1hz);
	clk_dv #(25000)		U2(clk, clk_1khz);
	counting 				U3(clk_1khz, clk_1hz, reset, set, hour, minute, hours, minutes, seconds, ampm);
	
	display 					U4(reset, hours, minutes, seconds, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	
endmodule
