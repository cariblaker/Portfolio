`timescale 1ns / 1ps

module test_ALU;

	wire cout, borrow, led_idle, led_wait, led_rdy, led_done;
	wire [3:0] Result;
	
	reg clk, reset, GO;
	reg [3:0]Data;
	reg [2:0]Opcode;


	ALU testy(clk, reset, Data, Opcode, GO, cout, borrow, Result, led_idle, led_wait, led_rdy, led_done);

	initial
		begin
		
			clk <= 1'b0;
			reset <= 1'b0; 
			GO <= 1'b0;
			
			Data <= 4'b1111;
			Opcode <= 3'b000;
		end
		
		
	always											//clock handling
		begin
			#10 clk <= ~clk;
		end
		
	always 
		begin
			#100 GO <= ~GO;
			#50 Data <= Data - 1;
		end
		
	always
		begin
			#100 Opcode <= Opcode + 1;
		end
		
	always
		begin
			#800 reset <= 1'b1;
		end


endmodule
