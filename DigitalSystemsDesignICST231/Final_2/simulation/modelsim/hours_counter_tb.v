`timescale 1ns / 1ps

module hours_counter_tb;

	reg seconds_clk, rst, set;
	reg [5:0] minutes, seconds;
	wire [3:0]hours;


	hours_counter T1(seconds_clk, rst, set, minutes, seconds, hours);
	
	
	initial
		begin
			seconds_clk <= 1'b0;
			rst <= 1'b0;
			set <= 1'b1;
			
			
			#500 set <= 1'b0;
			
			#90000 set <= 1'b1;
			#100 rst <= 1'b1;
			#100 rst <= 1'b0;
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
					begin
						seconds <= 0;
						if (minutes < 59)
							minutes <= minutes + 1;
						else
							minutes <= 0;
					end
			
			end
		
endmodule
