//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 6
//   Project: UART receiver
//   File Name: UART_rx.v
//   List of other files used: seg_7.v, Lab6.v, UART_tx.v, clk_dv.v, flag_x_domain
//-----------------------------------------------------------------------------     
//   Description of the Code 
//		this module is a state machine to receive the bits of UART
//-----------------------------------------------------------------------------    
//   Date: 02/15/2023
//   Version: 1.0
//		Revision: 
//			3/8/2023	- initial version
//			3/9/2023 - added flag_out output & logic for domain crossing, added
//							logic to capitalize lowercase letters
//-----------------------------------------------------------------------------


module UART_rx(
	input clk,
	input rst,
	input in,
	output reg [7:0]out,
	output reg flag_out,
	output reg error_led,
	output reg ready
	);
	
//-----------------------------------------------------------
// Parameter Declarations: localparam
//-----------------------------------------------------------
	localparam idle 	= 6'b100000;
	localparam start	= 6'b010000;
	localparam data 	= 6'b001000;
	localparam parity = 6'b000100;
	localparam stop 	= 6'b000010;
	localparam error	= 6'b000001;
	
	
//-----------------------------------------------------------
// Signal Declarations: reg
//-----------------------------------------------------------
	reg [7:0]data_out;				//stores the data to be put out
	reg [5:0]state;					//holds state
	reg [3:0]count;					//holds count for output index
	reg [4:0]clk_cnt;					//for over-sampling
	reg flag;
	
	
	initial
		begin
			ready <= 1'b1;
			out <= 0;
			error_led <= 0;
			state <= idle;
			count <= 0;
			clk_cnt <= 0;
			flag <= 0;
		end
		
		
	always @(posedge clk)			//state transition
		begin
			if (rst)
				begin
					state <= idle;
					count <= 0;
					clk_cnt <= 0;
					flag <= 0;
				end
			else
				begin
					case(state)
					
						idle :
							begin
								if (in == 1'b0)						//start bit received, move to data state
									state <= start;
								else
									state <= state;
								data_out <= 0;
							end
							
						start :
							begin

								if (clk_cnt == 4'b1111 && flag)
									begin
										state <= data;
										clk_cnt <= 0;
										flag <= 0;
									end
								else if (clk_cnt == 4'b1111 && !flag)
									begin
										state <= error;
										clk_cnt <= 0;
										flag <= 0;
									end
								else
									begin
										if (clk_cnt == 4'b0111)
											flag <= (in == 1) ? 1'b0 : 1'b1;
										else
											flag = flag;
										clk_cnt <= clk_cnt + 1;
										state <= state;
									end

							end
							
						data :
							begin
								if (clk_cnt == 4'b1111 && count == 4'b0111)			//if the clock count has gotten to 15 & index to 7, we can transition.
									begin
										state <= parity;										//move to parity
										clk_cnt <= 0;											//reset clk count for next state
										count <= 0;												//reset count for next transmission
										data_out <= data_out;
									end
								else
									begin
										if (clk_cnt == 4'b0111)
											begin
												data_out[count] <= in;						//latch in data at 7 clk counts		
												state <= state;								//stay in data state
												count <= count;
												clk_cnt <= clk_cnt + 1;
											end
										else if (clk_cnt == 4'b1111)
											begin
												state <= state;
												clk_cnt <= 0;
												count <= count + 1;
												data_out <= data_out;
											end
										else
											begin
												state <= state;
												clk_cnt <= clk_cnt + 1;
												count <= count;
												data_out <= data_out;
											end
									end	
								
							end
							
						parity :
							begin											
								if (clk_cnt == 4'b1111 && flag)
									begin
										state <= stop;
										clk_cnt <= 0;
										flag <= 1'b0;
									end
								else
									begin
										if (clk_cnt == 4'b0111 && (in == data_out[0] ^ data_out[1] ^ data_out[2] ^ data_out[3] ^ data_out[4] ^ data_out[5] ^ data_out[6] ^ data_out[7]))
											begin	
												flag <= 1'b1;
												state <= state;
												clk_cnt <= clk_cnt + 1;
											end
										else if (clk_cnt == 4'b0111 && (in != data_out[0] ^ data_out[1] ^ data_out[2] ^ data_out[3] ^ data_out[4] ^ data_out[5] ^ data_out[6] ^ data_out[7]))
											begin	
												flag <= 1'b0;
												state <= error;
												clk_cnt <= 0;
											end
										else
											begin
												state <= state;
												clk_cnt <= clk_cnt + 1;
												flag <= flag;
											end
									end
							end
							
						stop :
							begin
								if (clk_cnt == 4'b1111 && flag)
									begin
										state <= idle;
										clk_cnt <= 0;
										flag <= 1'b0;
									end
								else
									begin
										if (clk_cnt == 4'b0111 && in == 1'b1)
											begin
												flag <= 1'b1;
												state <= state;
												clk_cnt <= clk_cnt + 1;
											end
										else if (clk_cnt == 4'b0111 && in != 1'b1)
											begin
												state <= error;
												clk_cnt <= 0;
												flag <= 0;
											end
										else
											begin
												state <= state;
												clk_cnt <= clk_cnt + 1;
												flag <= flag;
											end
									end
							end
							
						error :
							begin
								state <= idle;
							end
							
						default :
							begin
								state <= idle;
							end
						endcase
				end
		end
		
		
		always @(posedge clk)										//output logic
			begin
			
				if (rst)
					begin
						out <= 0;
						error_led <= 1'b0;
						ready <= 1'b1;
						flag_out <= 0;
					end
					
				else
					begin
						case(state)
							idle :
								begin
									ready <= 1'b1;
									out <= out;
									error_led <= error_led;
									flag_out <= 0;
								end
							start :
								begin
									ready <= 1'b0;
									out <= 0;
									error_led <= 1'b0;
									flag_out <= 0;
								end
							data :
								begin
									error_led <= error_led;
									ready <= 1'b0;
									flag_out <= 0;
									if (count == 4'b0111)
										out = (data_out >= 97 && data_out <= 122) ? (data_out - 32) : data_out;
									else
										out <= out;
								end
							parity :
								begin
									ready <= 1'b0;
									out <= out;
									error_led <= error_led;
									flag_out <= 0;
								end
							stop :
								begin
									ready <= 1'b0;
									out <= out;
									error_led <= error_led;
									flag_out <= 1;
								end
							error :
								begin
									ready <= 1'b0;
									out <= out;
									error_led <= 1'b1;
									flag_out <= 0;
								end
							default :
								begin
									out <= 0;
									ready <= 1'b1;
									error_led <= 1'b0;
									flag_out <= 0;
								end
							endcase
					end
			end
	
	endmodule
	