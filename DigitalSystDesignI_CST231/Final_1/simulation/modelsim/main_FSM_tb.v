`timescale 1ns / 1ps

module main_FSM_tb;

	reg clk, rst, b3, b2, b1, b0;
	reg [2:0]left_in, right_in;
	reg [5:0]haz_in;
	
	wire [5:0]lights;
	wire L, H, R;

	main_FSM T1(clk, rst, b3, b2, b1, b0, left_in, haz_in, right_in, L, H, R, lights);
	
	
	initial
		begin
			clk <= 1'b0;
			rst <= 1'b0;
			{b3, b2, b1, b0} <= 4'b0000;
			{left_in, right_in} <= 6'b000000;
			haz_in <= 6'b000000;
			
			#50 b0 <= 1;									//right signal, R should go high
			#10 right_in <= 3'b101;						//led's should be 000101
			#10 right_in <= 3'b110;						//led's should be 000110
			#10 b1 <= 1;									//brake, led's should be 111110
			#10 b0 <= 0;									//right signal off, still braking, leds should be 111111
			#50 b3 <= 1;									//left signal on, L should go high
			#10 left_in <= 3'b001;						//led's should be 001111 (still braking)
			#10 b1 <= 0;									//brake off, led's should be 001000
			#10 left_in <= 3'b010;						//led's should be 010000
			#10 b2 <= 1;									//should transition into hazard state from left
			#10 haz_in <= 6'b010101;					//leds should be 010101
			#50 b1 <= 1;									//braking, led's should remain 010101
			#10 b0 <= 1;									//right turn signal, led's should remain
			#10 b3 <= 1;									//left turn signal, led's should remain
			#10 b3 <= 0;									//left off
			#10 b2 <= 0;									//hazards off--should go to braking in idle then brake & right signal, R high, led's 6'b111111 then 6'b111110
			#10 b0 <= 0;									//right off, brakes on
			#10 b1 <= 0;									//brakes off, leds 000000
			#10 b3 <= 1;									//left back on to test reset
			
			#200 rst <= 1'b1;
			#1 rst <= 1'b0;
		end
		
		
	always
		begin
			#1 clk <= ~clk;
		end
		
		
endmodule
