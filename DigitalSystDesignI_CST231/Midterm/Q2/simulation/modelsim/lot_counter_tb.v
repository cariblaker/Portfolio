`timescale 1ns / 1ps

module lot_counter_tb;

	reg sens1, sens2, clk, rst;

	wire [6:0] ones, tens;
	
	lot_counter testy(clk, rst, sens1, sens2, ones, tens);

	initial
		begin
		
			{clk, rst, sens1, sens2} <= 4'b0000;
			#4000 sens2 <= ~sens2;														//random error sequence generation
			#10	sens2 <= ~sens2;
			#10	sens1 <= ~sens1;
			#20	sens1 <= ~sens1;
			#50 rst <= 1;																	
			#10 rst <= 0;
			
		end
		
	always																					//clock handling
		begin
			#10 clk <= ~clk;
		end
		
	always
		begin
			#20 sens2 <= ~sens2;					//2 up
			#20 sens1 <= ~sens1;					//1 up
			
			#20 sens2 <= ~sens2;					//2 down
			#20 sens1 <= ~sens1;					//1 down		--1 car
			
			#40 sens2 <= ~sens2;					//2 up
			#20 sens1 <= ~sens1;					//1 up
			
			#20 sens2 <= ~sens2;					//2 down
			#20 sens1 <= ~sens1;					//1 down		--2 cars
				
			#40 sens2 <= ~sens2;					//2 
			#20 sens1 <= ~sens1;
			
			#20 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;									//3cars
			
			#40 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#20 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;									//4
			
			#40 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#20 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;									//5
			
			#40 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#20 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;									//6
			
			#40 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#20 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#40 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#20 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#40 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#20 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#40 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#20 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#40 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#20 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#40 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#20 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#40 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#20 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#40 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#20 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#40 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#20 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#40 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
			#60 sens1 <= ~sens1;				//begin cars leaving
			
			#40 sens2 <= ~sens2;
			#20 sens1 <= ~sens1;
			
		end


endmodule
