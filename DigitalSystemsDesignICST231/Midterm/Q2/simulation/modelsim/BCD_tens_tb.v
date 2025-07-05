`timescale 1ns / 1ps

module BCD_tens_tb;

	reg inc, dec, clk, rst;

	wire [3:0]num;
	
	BCD_tens testy(clk, rst, inc, dec, num);

	initial
		begin
		
			{clk, rst, inc, dec} <= 4'b0000;
			#850 rst <= 1;																	
			#50 rst <= 0;
		end
		
		
	always																					//clock handling
		begin
			#10 clk <= ~clk;
		end
		
	always
		begin
		
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;
			#10 inc <= ~inc;												
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;
			#10 dec <= ~dec;														//at 200, this should bring the down high and the count to 9
		end


endmodule
