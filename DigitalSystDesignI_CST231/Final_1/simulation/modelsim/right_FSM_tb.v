`timescale 1ns / 1ps

module right_FSM_tb;

	reg clk, rst, ena;
	wire [2:0]leds;


	right_FSM T1(clk, rst, ena, leds);
	
	
	initial
		begin
			clk <= 1'b0;
			rst <= 1'b0;
			ena <= 1'b0;
			
			#50 ena <= 1'b1;
			#5000 ena <= 1'b0;
			#10 ena <= 1'b1;
			#995 ena <= 1'b0;
			#10 ena <= 1'b1;
			
			#200 rst <= 1'b1;
			#1 rst <= 1'b0;
		end
		
		
	always
		begin
			#1 clk <= ~clk;
		end
		
		
endmodule
