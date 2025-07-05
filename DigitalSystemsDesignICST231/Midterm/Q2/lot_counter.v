//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Midterm 2
//   Project: Car Lot Counter
//   File Name: lot_counter.v
//   List of other files used: sensor_FSM.v, BCD_ones.v, seg_7.v, BCD_tens.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		top level ties project together
//-----------------------------------------------------------------------------    
//   Date: 03/02/2023
//   Version: 1.0
//-----------------------------------------------------------------------------

module lot_counter(
	input clk,
	input rst,
	input sens1,
	input sens2,
	output [6:0]ones,
	output [6:0]tens
);

//-----------------------------------------------------------
// Signal Declarations: wire
//-----------------------------------------------------------

	wire increment, decrement, up, down;											
	wire [3:0] count_ones, count_tens;
	

	sensor_FSM 	FSM(clk, rst, sens1, sens2, increment, decrement);
	BCD_ones 	Ones(rst, increment, decrement, up, down, count_ones);
	BCD_tens 	Tens(rst, up, down, count_tens);
	seg_7 		display_ones(count_ones, ones);
	seg_7			display_tens(count_tens, tens);
	
	
endmodule
	