`timescale 1ns / 1ps

module seconds_counter_tb;

	reg clk, seconds_clk, rst, set;
	wire [5:0]seconds;


	seconds_counter T1(clk, rst, set, seconds);
	
	
	initial
		begin
			clk <= 1'b0;
			rst <= 1'b0;
			set <= 1'b0;
			
			
			#50 set <= 1'b1;
			
			#100 set <= 1'b0;
			#10 rst <= 1'b1;
			#10 rst <= 1'b0;
		end

		
	always
		begin
			#10 clk <= ~clk;
		end
		
		
endmodule
