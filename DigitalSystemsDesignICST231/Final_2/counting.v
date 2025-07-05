

module counting(
	input project_clk, clk_1hz,
	input rst, set, set_h, set_m,
	output [3:0] hours,
	output [5:0] minutes, seconds,
	output am_pm
);

	wire setting, setting_h, setting_m;

	clock_control 		U1(project_clk, rst, set, set_h, set_m, setting, setting_h, setting_m);
	hours_counter 		U2(clk_1hz, rst, setting_h, minutes, seconds, hours);
	minutes_counter 	U3(clk_1hz, rst, setting_m, seconds, minutes);
	seconds_counter 	U4(clk_1hz, rst, setting, seconds);
	ampm 					U5(clk_1hz, rst, setting_h, hours, minutes, seconds, am_pm);
	

endmodule
