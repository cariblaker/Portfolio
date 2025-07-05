//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 6
//   Project: UART receiver
//   File Name: flag_x_domain.v
//   List of other files used: seg_7.v, Lab6.v, UART_tx.v, clk_dv.v, UART_rx.v
//-----------------------------------------------------------------------------     
//   Description of the Code 
//		this module stretches delays a pulse signal to be witnessed by a different
//		clock edge
//-----------------------------------------------------------------------------    
//   Date: 02/15/2023
//   Version: 1.0
//		Revision: 
//			3/9/2023	- initial version
//-----------------------------------------------------------------------------

module flag_x_domain(
  input clkA, 
  input pulse_in, 
  input clkB,
  output pulse_out
);


//-----------------------------------------------------------
// Signal Declarations: reg
//-----------------------------------------------------------
	reg flag_clkA;
	reg [2:0]sync;
	

	always @(posedge clkA)
		begin
			flag_clkA <= flag_clkA ^ pulse_in;
		end
	
	always @(posedge clkB)
		begin
			sync <= {sync[1:0], flag_clkA};
		end
		
	assign pulse_out = (sync[2] ^ sync[1]);
		
endmodule
