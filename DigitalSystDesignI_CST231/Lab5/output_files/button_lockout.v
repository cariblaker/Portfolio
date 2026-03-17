
//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 5
//   Project: UART transmitter
//   File Name: button_lockout.v
//   List of other files used: clk_dv.v, UART_tx.v, mux.v, Lab5.v
//-----------------------------------------------------------------------------     
//   Description of the Code 
//		this module is a state machine to transmit the bits of UART
//-----------------------------------------------------------------------------    
//   Date: 02/15/2023
//   Version: 1.0
//		Revision: 
//			2/15/2023	- initial version
//-----------------------------------------------------------------------------



module button_lockout(
	input clk,
	input reset,
	input L,
	output reg P
);

//-----------------------------------------------------------
// Parameter Declarations:
//-----------------------------------------------------------
	// Name the States
	parameter [1:0] stateA = 2'b00,
						 stateB = 2'b01,
						 stateC = 2'b11;

//-----------------------------------------------------------
// Signal Declarations: reg
//-----------------------------------------------------------
	// Create memory for the state machine
	reg [1:0] cur_state;
	
	
	// Always block to handle State Machine
	always @(posedge clk)
	begin
	
		if(reset)
			cur_state <= stateA;
		else
			case(cur_state)
				stateA :
					if(L)
						cur_state <= stateB;
					else
						cur_state <= cur_state;
				stateB :
					if(L)
						cur_state <= stateC;
					else
						cur_state <= stateA;
				stateC :
					if(L)
						cur_state <= cur_state;
					else
						cur_state <= stateA;
				default : cur_state <= stateA;
			endcase
			
	end
	
	
	// Always block to handle Combinational Outputs
	always @(cur_state)
	begin
	
		case(cur_state)
			stateA  : P <= 0;
			stateB  : P <= 1;
			stateC  : P <= 0;
			default : P <= 0;
		endcase
		
	end



endmodule
