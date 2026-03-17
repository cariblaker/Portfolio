//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 6
//   Project: UART receiver
//   File Name: Lab6.v
//   List of other files used: clk_dv.v, UART_rx.v, seg_7.v, UART_tx.v,
//										flag_x_domain
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this module is the top level for lab6
//-----------------------------------------------------------------------------    
//   Date: 3/8/2023
//   Version: 1.1
//		Revision: 
//			3/8/23	- initial version
//			3/9/23	- added UART_tx, second clock divider, changed signal names
//							added flag_x_domain module
//-----------------------------------------------------------------------------

module Lab6(
	input clk,
	input reset,							//SW[0]
	input serial_input,					//GPIO_1 [1]
	output error_led,						//LEDR[0]
	output ready_led,						//LEDR[1]
	output [6:0]HEX0,						//smaller digit
	output [6:0]HEX1,						//larger digit
	output serial_out,					//GPIO_1 [3]
	output ready							//LEDR[9]
);


//-----------------------------------------------------------
// Signal Declarations: wire
//-----------------------------------------------------------
	wire [7:0]out;
	wire clk_9600hz, clk_153669hz, start, go;

	
	clk_dv			#(163)U1		(clk, clk_153669hz);
	clk_dv 			#(2603)U2	(clk, clk_9600hz);
	UART_rx 			U3				(clk_153669hz, reset, serial_input, out, start, error_led, ready_led);
	flag_x_domain 	U4				(clk_153669hz, start, clk_9600hz, go);
	seg_7				U5				(out[3:0], reset, HEX0);
	seg_7				U6				(out[7:4], reset, HEX1);
	UART_tx 			U7				(clk_9600hz, reset, go, out, serial_out, ready);
	 
	
	
endmodule
