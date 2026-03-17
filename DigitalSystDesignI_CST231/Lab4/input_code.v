//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 4
//   Project: Intro to Heirarchical Design
//   File Name: keypad_decode.v
//   List of other files used: clk_dv.v, seg_7.v, kepad.v, board_in_out.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this module uses a state machine to input the code entered into registers
//-----------------------------------------------------------------------------    
//   Date: 3/12/2023
//   Version: 1.0
//		Revision: 
//			3/12/23	- intial version
//-----------------------------------------------------------------------------

module input_code (
	input clk,
	input key_pressed,
	input [3:0]key,
	output reg [15:0]seg_out,
	output reg [15:0]code_out,
	output reg start 
);

	localparam idle 			= 2'b00;
	localparam intake 	 	= 2'b01;
	localparam wait_time 	= 2'b11;
	localparam done 	 		= 2'b10;

	reg [5:0]	count;
	reg [1:0]	state; 
	reg [11:0]	count_sec;

	
	initial 
		begin
			count <= 0;
			state <= idle;
			count_sec <= 0;
		end
		
	always @(posedge clk)													//state transition logic
		begin
		
			case (state)
				idle :
					begin
						if (key_pressed)
							begin
								state <= intake;
								count_sec <= count_sec + 1;				//start the count
							end
							
						else
							begin
								state <= state;
								count_sec <= 0;
							end
					end	
				
				intake :
					begin
						if (key == 4'b1110)									//* hit,  reset
							begin
								state <= idle;
								count_sec <= 0;
							end
						else if (key == 4'b1111)							//# hit, time to check
							begin
								state <= done;
								count_sec <= 0;
							end
						else
							begin													//otherwise, go to wait state for next press/timeout
								state <= wait_time;
								count_sec <= count_sec + 1;
							end
					end
					
				wait_time :
					begin
						if (count_sec == 3750)								//3750 clock cycles @ 250hz = 15 seconds til timeout
							begin
								state <= idle;									//timeout puts us back in idle, resets second count
								count_sec <= 0;
							end
						else if (key_pressed)								//if another key has been pressed, go to intake and restart count
							begin
								state <= intake;
								count_sec <= 0;
							end
						else
							begin
								count_sec <= count_sec + 1;				//otherwise, keep counting
							end
					end
				
				done :
					begin
						state <= idle;
						count_sec <= 0;
					end
					
				default :
					begin
						state <= idle;
						count_sec <= 0;
					end
					
				endcase
		end
		
		
		
	always @(posedge clk)													//output logic
		begin
		
			case (state)
				idle : 
					begin
						seg_out <= seg_out;
						code_out <= code_out;
						start <= 1'b0;
					end
				intake :
					begin
						if (key == 4'b1110)									//* key hit for reset
							begin 
								seg_out <= 4'h1111;							//turns segs off
								code_out <= code_out;
								start <= start;
							end
						else if (key == 4'b1111)
							begin
								seg_out <= seg_out;							//if the # key is hit, put the received code into the code register
								code_out <= seg_out;
								start <= start;
							end
						else
							begin
								seg_out <= {seg_out[12:0], key};			//if neither of those keys are the ones hit, put the key hit into the segments
								code_out <= code_out;
								start <= start;
							end
					end
				wait_time :
					begin
						seg_out <= seg_out;
						code_out <= code_out;
						start <= start;
					end
				done :
					begin
						seg_out <= seg_out;
						code_out <= seg_out;
						start <= 1'b1;
					end
				default :
					begin
						seg_out <= 4'b1111;
						code_out <= seg_out;
						start <= 1'b0;
					end
				endcase
				
		end


	

endmodule 
