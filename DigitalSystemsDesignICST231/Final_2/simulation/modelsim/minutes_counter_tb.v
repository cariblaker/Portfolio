`timescale 1ns / 1ps

module minutes_counter_tb;

	reg seconds_clk, rst, set;
	reg [5:0]seconds;
	wire [5:0]minutes;


	minutes_counter T1(seconds_clk, rst, set, seconds, minutes);
	
	
	initial
		begin
			seconds_clk <= 1'b0;
			seconds <= 6'b000000;
			rst <= 1'b0;
			set <= 1'b1;
			
			
			#1400 set <= 1'b0;
			
			#14000 set <= 1'b1;
			#10 rst <= 1'b1;
			#10 rst <= 1'b0;
			set <= 1'b0;
		end
		
		
		
		always
			begin
				#10 seconds_clk <= ~seconds_clk;
			end
		
		always @(posedge seconds_clk)
			begin
			
				if (seconds < 59)
					seconds <= seconds + 1;

				else
					seconds <= 0;
			
			end
		
		
endmodule
