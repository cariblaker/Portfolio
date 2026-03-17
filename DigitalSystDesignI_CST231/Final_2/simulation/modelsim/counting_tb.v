`timescale 1ns / 1ps

module counting_tb;

	reg clk, clk_1hz, rst, set, set_h, set_m;
	wire setting, setting_h, setting_m;
	wire [3:0] hours;
	wire [5:0] minutes, seconds;
	wire am_pm;
		

	counting T1(clk, clk_1hz, rst, set, set_h, set_m, hours, minutes, seconds);
	
	clock_control T2(clk, rst, set, set_h, set_m, setting, setting_h, setting_m);
	seconds_counter T3(clk_1hz, rst, setting, seconds);
	minutes_counter T4(clk_1hz, rst, setting_m, seconds, minutes);
	hours_counter T5(clk_1hz, rst, setting_h, minutes, seconds, hours);
	ampm T6(clk_1hz, rst, setting, hours, minutes, seconds, am_pm);
	
	initial
		begin
			clk <= 1'b0;
			clk_1hz <= 1'b0;
			rst <= 1'b0;
			{set, set_h, set_m} <= 3'b111;
			
			
			#5000 set <= 1'b0;										//everything should pause for 500ns after this
			#500 set_h <= 1'b0;									//then hours start counting up by the second
			#500 set_m <= 1'b0;									//then minutes and hours
			#500 set_h <= 1'b1;									//then just minutes
			#3000 set <= 1'b1;									//then normal clock counting
			#500 set_h <= 1'b0;									//this should have no effect
			#500 set_m <= 1'b1;									//also no effect
			#10000 rst <= 1'b1;									//reset at 	15550			
			#50 rst <= 1'b0;
			set <= 1'b0;
			#50 set <= 1'b1;
			#50 set_h <= 1'b1;
		end
		

		
		always
		begin
			#10 clk <= ~clk;
		end
		
		
				always
		begin
			#50 clk_1hz <= ~clk_1hz;
		end
		
endmodule
