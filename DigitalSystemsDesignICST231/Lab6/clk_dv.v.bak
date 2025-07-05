//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 5
//   Project: UART transmitter
//   File Name: clk_dv.v
//   List of other files used: mux.v, button_lockout.v, UART_tx.v, Lab5.v
//-----------------------------------------------------------------------------     
//   Description of the Code 
//		this module divides clock time, no reset
//-----------------------------------------------------------------------------    
//   Date: 02/15/2023
//   Version: 1.0
//		Revision: 
//			2/15/2023	- initial version
//-----------------------------------------------------------------------------


module clk_dv
	#(parameter CLK_DIV = 12500) (
	input clk,
	output reg new_clk
);
 
//-----------------------------------------------------------
// Signal Declarations: reg
//-----------------------------------------------------------
reg [25:0] count;


always @(posedge clk)			//handles count
	begin

		if (count < CLK_DIV - 1)
			count <= count + 1;
				
		else
			count <= 0;
	
	end
	
	
	always @(posedge clk)		//handles output
	begin
			
		if (count == CLK_DIV - 1)
			new_clk <= ~new_clk;						
				
		else
			new_clk <= new_clk;
	
	end

	
endmodule
