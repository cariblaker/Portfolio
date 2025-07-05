`timescale 1ns / 1ps

module haz_tb;

	reg clk, rst, ena;
	wire [5:0]leds;


	haz T1(clk, rst, ena, leds);
	
	
	initial
		begin
			clk <= 1'b0;
			rst <= 1'b0;
			ena <= 1'b0;
			
			#100 ena <= 1'b1;
			#5000 ena <= 1'b0;
			#100 ena <= 1'b1;
			#995 ena <= 1'b0;
			#100 ena <= 1'b1;
			
			#200 rst <= 1'b1;
			#1 rst <= 1'b0;
		end
		
		
always
		begin
			#1 clk <= ~clk;
		end
		
		
endmodule
