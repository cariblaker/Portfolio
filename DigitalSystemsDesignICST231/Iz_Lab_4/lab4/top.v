module top(
	input clk,
	input [3:0] columns,
	input reset,
	output [3:0] rows,
	output [6:0] HEX3,
	output [6:0] HEX2,
	output [6:0] HEX1,
	output [6:0] HEX0,
	output error,
	output open,
	output unlocking
);


wire key_pressed, clk_out, P, go;
wire [3:0] key;
wire [15:0] code_out, seg_out;

clock_divider #(100000) U1(clk, clk_out); 

keypad_interface U2(clk_out, cols, key, key_pressed, rows);

lockout U3(clk_out, key_pressed, P);

code U4(clk_out, P, key, seg_out, code_out, go);

check U5(clk_out, reset, code_out, go, error, open, unlocking);

seven_seg U6(seg_out[15:12], segment_four);
seven_seg U7(seg_out[11:8], segment_three);
seven_seg U8(seg_out[7:4], segment_two);
seven_seg U9(seg_out[3:0], segment_one);




endmodule 