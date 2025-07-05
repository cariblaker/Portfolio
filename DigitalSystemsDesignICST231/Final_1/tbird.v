

module tbird(
	input clk,
	input rst,										//SW 0
	input LEFT, RIGHT, BK, HAZ,
	output [5:0]leds								//LEDR 9, 8, 7, 2, 1, 0
);

//-----------------------------------------------------------
// Signal Declarations: wire
//-----------------------------------------------------------
	wire b0_locked, b2_locked, b3_locked, L, H, R;
	wire [2:0] left_in, right_in;
	wire [5:0] haz_in;
	

	clk_dv 		#(25000)	U1(clk, rst, clk_1khz);
	button_lock				U2(clk_1khz, rst, RIGHT, b0_locked);
	button_lock				U3(clk_1khz, rst, HAZ, b2_locked);
	button_lock				U4(clk_1khz, rst, LEFT, b3_locked);
	
	main_FSM					U5(clk_1khz, rst, b3_locked, b2_locked, BK, b0_locked, left_in, haz_in, right_in, L, H, R, leds);
	left_FSM					U6(clk_1khz, rst, L, left_in);
	right_FSM				U7(clk_1khz, rst, R, right_in);
	haz						U8(clk_1khz, rst, H, haz_in);



endmodule
