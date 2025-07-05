`timescale 1ns / 1ps

module clock_control_tb;

	reg clk, rst, set, set_h, set_m;
	wire setting, setting_h, setting_m;
		

	clock_control T1(clk, rst, set, set_h, set_m, setting, setting_h, setting_m);
	
	
	initial
		begin
			clk <= 1'b0;
			rst <= 1'b0;
			{set, set_h, set_m} <= 3'b111;
			
			
			#50 set <= 1'b0;
			#50 set_h <= 1'b0;
			#50 set_m <= 1'b0;
			#50 set_h <= 1'b1;
			#300 set <= 1'b1;
			#50 set_h <= 1'b0;
			#50 set_m <= 1'b1;
			#100 rst <= 1'b1;
			#50 rst <= 1'b0;
			set <= 1'b0;
			#50 set <= 1'b1;
			#50 set_h <= 1'b1;
		end
		

		
		always
		begin
			#10 clk <= ~clk;
		end
		
		
endmodule
