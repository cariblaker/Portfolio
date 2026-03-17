`timescale 1ns / 1ps

module UART_rx_tb;

	reg clk, rst, in;
	wire[7:0]out;
	wire flag_out, error, ready;

	UART_rx T1(clk, rst, in, out, flag_out, error, ready);
	
	
	initial
		begin
			clk <= 1'b0;
			rst <= 1'b1;
			in <= 1'b1;
			
			#20 rst <= 1'b0;
			

			
			#30 in <= 1'b0;								//start bit
			#32 in <= 1'b0;								//this would be a B... but output should be 01000010
			#32 in <= 1'b1;
			#32 in <= 1'b0;
			#32 in <= 1'b0;
			#32 in <= 1'b0;
			#32 in <= 1'b0;
			#32 in <= 1'b1;
			#32 in <= 1'b0;
			#32 in <= 1'b0;								//parity bit
			#32 in <= 1'b1;								//stop bit
			
			
			#2777 rst <= 1'b1;
			#1 rst <= 1'b0;
		end
		
		
	always
		begin
			#1 clk <= ~clk;
		end
		
		
endmodule
