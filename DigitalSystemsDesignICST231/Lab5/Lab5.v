  //-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 5
//   Project: UART transmitter
//   File Name: Lab5.v
//   List of other files used: clk_dv.v, UART_tx.v, button_lockout.v, mux.v
//-----------------------------------------------------------------------------     
//   Description of the Code 
//		top-level module 
//-----------------------------------------------------------------------------    
//   Date: 02/15/2023
//   Version: 1.0
//		Revision: 
//			2/15/2023	- initial version
//			3/3/2023		- removed register for switch input, added mux
//-----------------------------------------------------------------------------


module Lab5( 
	input clk,
	input reset,
	input [1:0]cntrl,
	input [7:0]SW,
	output out,
	output ready
);
 
//-----------------------------------------------------------
// Signal Declarations: wire
//-----------------------------------------------------------
	wire clk_9600hz, UART_cntrl, button_0, button_1;
	wire [7:0]data;


	clk_dv #(2603)U1(clk, clk_9600hz);
	button_lockout U2(clk_9600hz, reset, cntrl[0], button_0);
	button_lockout U3(clk_9600hz, reset, cntrl[1], button_1);
	mux U4(clk_9600hz, reset, ready, button_0, button_1, SW, data, UART_cntrl);
	UART_tx U5(clk_9600hz, reset, UART_cntrl, data, out, ready);


endmodule



