module Lab08(
	input clk,
	input reset,
	input sen,
	output [3:0] rgb1,
	output [3:0] rgb2,
	output led
);


	wire wire1;

	ClkDivider U1(clk, reset, wire1);
	traffic_fsm U2(wire1, sen, reset, rgb1, rgb2);
	
	assign led = wire1;


endmodule
