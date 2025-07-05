//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 3
//   Project: Multiplexed Display
//   File Name: clk_dv.v
//   List of other files used: counter.v, Lab3.v, seg_7.v, bin2bcd.v,
//		back_end.v, decoder.v, mux.v, control.v, front_end.v, top_level.v
//-----------------------------------------------------------------------------     
//   Description of the Code 
//		this module divides clock time, and includes an asynchronous
//		reset. It's set for 12.5M because of the 4 displays, but is parameterized
//		to allow for any iteration of clock division
//-----------------------------------------------------------------------------    
//   Date: 01/25/2023
//   Version: 1.0
//		Revision: 
//			1/25/2023	- initial version
//			1/28/2023	- added reg declaration
//-----------------------------------------------------------------------------
//for every display, 500 hz. so do 2 khz total for the 4 displays. 50M/12.5k = 4k/2 
//for the counter clock, it'll be 12.5M as the param

module clk_dv
	#(parameter CLK_DIV = 12500) (
	input clk,
	input rst,
	output reg new_clk
);

//-----------------------------------------------------------
// Signal Declarations: reg
//-----------------------------------------------------------

reg [25:0] count;

initial
	begin
	
		count <= 0;
	
	end

always @(posedge clk or posedge rst)			//handles count
	begin
		
		if (rst)
			count <= 0;
			
		else if (count < CLK_DIV - 1)
			count <= count + 1;
				
		else
			count <= 0;
	
	end
	
	
	always @(posedge clk or posedge rst)		//handles output
	begin
		
		if (rst)
			new_clk <= 0;
			
		else if (count == CLK_DIV - 1)
			new_clk <= ~new_clk;						
				
		else
			new_clk <= new_clk;
	
	end

	
endmodule
