//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 5
//   Project: UART transmitter
//   File Name: UART_tx.v
//   List of other files used: clk_dv.v, Lab6.v, UART_tx.v, seg_7.v, flag_X_domain.v
//-----------------------------------------------------------------------------     
//   Description of the Code 
//		this module is a state machine to transmit the bits of UART
//-----------------------------------------------------------------------------    
//   Date: 03/09/2023
//   Version: 1.0
//		Revision: 
//			2/15/2023	- initial version
//			2/22/2023	- added LED and handshake
//-----------------------------------------------------------------------------


module UART_tx (
	input clk,
	input reset,
	input cntrl,
	input [7:0]data,
	output reg out,
	output reg ready
);


//-----------------------------------------------------------
// Parameter Declarations: localparam
//-----------------------------------------------------------
	localparam start	= 5'b00001;
	localparam shift	= 5'b00010;
	localparam parity = 5'b00100;
	localparam stop 	= 5'b01000;
	localparam idle 	= 5'b10000;

//-----------------------------------------------------------
// Signal Declarations: reg
//-----------------------------------------------------------
	reg [7:0] data_in;
	reg [4:0] state;
	reg [3:0] count;


	initial
	begin

		state <= idle;
		count <= 4'b0000;

	end
	 
	 
	 //next state logic
	 always @(posedge clk)
	 begin

		if (reset)
			state <= idle;
		else
		begin
			case(state)
				
				idle :
					begin
						if (cntrl)
							state <= start;
						else
							state <= state;
					end
					
				start :
					begin
						state <= shift;
					end	
				
				shift :
					begin
						
						if (count < 4'b0111)
							begin
								state <= state;
								count <= count + 1;
							end
						
						else
							begin
								state <= parity;
								count <= 4'b0000;
							end
					
					end
				
				parity :
					begin
						state <= stop;
					end
				
				stop :
					begin
						state <= idle;
					end
				
				default : 
					begin
						state <= idle;
					end
				
			endcase
			
		end
			
	 end															//always
	 
	 
	 
	 always @(posedge clk)							//output logic
	 begin
	 
		case(state)
			idle 	 : 
				begin
					data_in <= data;
					out <= 1'b1;
					ready <= 1'b1;
				end
				
			start  : 
				begin
					ready <= 1'b0;
					out <= 1'b0;
				end
				
			shift  : 
				begin
					ready <= 1'b0;
					out <= data_in[count];
				end
				
			parity : 
				begin
					ready <= 1'b0;
					out <= data_in[0] ^ data_in[1] ^ data_in[2] ^ data_in[3] ^ data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7];
				end
				
			stop   : 
				begin
					ready <= 1'b0;
					out <= 1'b1;
				end
				
			default:
				begin
					ready <= 1'b1;
					out <= 1'b1;
				end
				
		endcase
	 
	 end
	 
	 
 
 endmodule
 
