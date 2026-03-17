`timescale 1ns / 1ps

module sensor_FSM_tb;

	wire increment, decrement;
	
	reg clk, rst, sens1, sens2;

	sensor_FSM  testy(clk, rst, sens1, sens2, increment, decrement);

	initial
		begin
		
			{clk, rst, sens1, sens2} <= 4'b0000;
			#800 rst <= 1;																	//also back to idle
			
		end
		
		
	always																					//clock handling
		begin
			#10 clk <= ~clk;
		end
		
	always
		begin
		
			#20 sens1 <= ~sens1;
			#20 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			#20 sens2 <= ~sens2;
			#60 sens2 <= ~sens2;
			
		end


endmodule
