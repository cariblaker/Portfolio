//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 5
//   Project: UART transmitter
//   File Name: mux.v
//   List of other files used: clk_dv.v, UART_tx.v, button_lockout.v, Lab5.v
//-----------------------------------------------------------------------------     
//   Description of the Code 
//		top-level module 
//-----------------------------------------------------------------------------    
//   Date: 02/15/2023
//   Version: 1.0
//		Revision: 
//			2/15/2023	- initial version
//			3/8/2023		- separated state transition, internal logic,&output logic
//								added two states to fix race conditions
//-----------------------------------------------------------------------------    


module mux(
	input clk,
	input reset,
	input ready,
	input button_0,
	input button_1,
	input [7:0]data_sw,
	output reg [7:0]data_out,
	output reg enable
);

//-----------------------------------------------------------
// Parameter Declarations: localparam
//-----------------------------------------------------------

	localparam idle 		= 5'b00001;
	localparam b1 			= 5'b00010;
	localparam b2 			= 5'b00100;
	localparam b2waitA 	= 5'b01000;
	localparam b2waitB 	= 5'b10000;
	
//-----------------------------------------------------------
// Signal Declarations: reg
//-----------------------------------------------------------
	reg [4:0] 	state;
	reg [3:0] 	count;
	reg 			done;
	
//-----------------------------------------------------------
// Signal Declarations: wire
//-----------------------------------------------------------
	wire [7:0] foo [0:10];
	
	assign foo	[0]  = "H";
	assign foo	[1]  = "e";
	assign foo	[2]  = "l";
	assign foo	[3]  = "l";
	assign foo	[4]  = "o";
	assign foo	[5]  = " ";
	assign foo	[6]  = "C";
	assign foo	[7]  = "a";
	assign foo	[8]  = "r";
	assign foo	[9]  = "i";
	assign foo	[10] = "!";


	initial
		begin
	
			state <= idle;
			count <= 0;
			done <= 0;
	
		end
		
	always @(posedge clk)
		begin
			case (state)
				idle :
					begin
						count <= 4'b0000;
						done <= 1'b0;
					end
				b1 :
					begin
						count <= 4'b0000;
						done <= 1'b0;
					end
				b2 :
					begin
						count <= count + 1;
							
						if (count < 4'b1001)
							done <= 0;
						else
							done <= 1;
					end
				b2waitA :
					begin
						count <= count;
						done <= done;
					end
				b2waitB :
					begin
						count <= count;
						done <= done;
					end
				default : 
					begin
						count <= 4'b0000;
						done <= 1'b0;
					end
				endcase
		end
		
		
	always @(posedge clk)										//next state logic
		begin
		
			if (reset)
				state <= idle;
		
			else
				case (state)
				
					idle :
						begin
							if (button_0)
								state <= b1;
							else if (button_1)
								state <= b2;
							else
								state <= idle;
						end
					b1 :
						begin
							state <= idle;
						end
						
					b2 :
						begin
							if (done == 1'b1)
								state <= idle;

							else
								state <= b2waitA;

						end
					b2waitA :
						begin
							if (~ready)
								state <= b2waitB;
							else
								state <= state;
						end
						
					b2waitB :
						begin
							if (ready)
								state <= b2;
							else
								state <= state;
						end
						
					default : state <= idle;
						
				endcase
					
		
		end


	always @(posedge clk)							//output logic
		begin
		
			case (state)
			
				idle : 
					begin
						enable <= 0;
						data_out <= 0;
					end
					
				b1 :
					begin
						data_out <= data_sw;
						enable <= 1;
					end
					
				b2 :
					begin
						if (ready)
							begin
								data_out <= foo[count];
								enable <= 1;
							end
						else
							begin
								enable <= 0;
								data_out <= data_out;
							end
							
					end										//b2 case end
				b2waitA :
					begin
						enable <= 0;
						data_out <= data_out;
					end
					
				b2waitB :
					begin
						enable <= 0;
						data_out <= data_out;
					end
					
				default :
					begin
						data_out <= data_out;
						enable <= 0;
					end
			
					
				endcase
		
		end													//end always


endmodule
