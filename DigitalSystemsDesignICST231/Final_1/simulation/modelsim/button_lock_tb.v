`timescale 1ns / 1ps

module button_lock_tb;

	reg clk, rst, button;
	wire signal;


	button_lock T1(clk, rst, button, signal);
	
	
	initial
		begin
			clk <= 1'b0;
			rst <= 1'b0;
			button <= 1'b0;
			
			#50 button <= 1'b1;
			#50 button <= 1'b0;
			#50 button <= 1'b1;
			#50 button <= 1'b0;
			#100 button <= 1'b1;
			
			#100 rst <= 1'b1;
			#10 rst <= 1'b0;
		end
		
		
	always
		begin
			#1 clk <= ~clk;
		end
		
		
endmodule
