//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Midterm 2
//   Project: Car Lot Counter
//   File Name: sensor_FSM.v
//   List of other files used: BCD_ones.v, BCD_tens.v, seg_7.v, lot_counter.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		handles sensor input using FSM to output proper inc/dec for count
//-----------------------------------------------------------------------------    
//   Date: 03/01/2023
//   Version: 1.0
//-----------------------------------------------------------------------------

module sensor_FSM(
	input clk,
	input rst,
	input sens1,
	input sens2,
	output reg increment,
	output reg decrement
);


	localparam hit0 = 4'b0011;						//no sensors have been hit
	localparam hit1 = 4'b1011;						//one sensor has been hit
	localparam hit2 = 4'b1111;						//two sensors have been hit and one of the two proper sequences is happening
	localparam hit3 = 4'b1101;						//etc.
	localparam hit4 = 4'b1100;
	
//-----------------------------------------------------------
// Signal Declarations: reg
//-----------------------------------------------------------
	
	reg [3:0]state;									//state register
	reg entering;										//flag for possible car entering
	reg leaving;										//flag for possible car leaving
	
	
	initial
		begin
			state <= hit0;
		end


	always @(posedge clk or posedge rst)
		begin
			if (rst)
				begin
					state <= hit0;
					entering <= 1'b0;
					leaving <= 1'b0;
				end
			
			else
				begin
		
					case (state)
						hit0:
							begin
					
								if (sens1 && !sens2)
									begin
										leaving <= 1;
										state <= hit1;
									end
								else if (sens2 && !sens1)
									begin
										entering <= 1;
										state <= hit1;
									end
								else
									begin
										{leaving, entering} <= 2'b00;
										state <= state;
									end
								
							end
						hit1:
							begin
								if (sens1 && sens2)
									state <= hit2;
								else if ( (leaving && !sens1) | (entering && !sens2) )
									begin
										state <= hit0;
										leaving <= 1'b0;
										entering <= 1'b0;
									end
								else
									state <= state;
							end
						hit2:
							begin
								if ( (leaving && sens2 && !sens1) | (entering && sens1 && !sens2) )
									state <= hit3;
								else if ( (leaving && !sens2) | (entering && !sens1) )
									begin
										state <= hit0;
										leaving <= 1'b0;
										entering <= 1'b0;
									end
								else
									state <= state;
							end	
						hit3:
							begin
								if (!sens1 && !sens2)
									begin
										state <= hit4;
									end
								else if ( (leaving && sens1) | (entering && sens2) )
									begin
										state <= hit0;
										{entering, leaving} <= 2'b00;
									end
								else
									state <= state;
							end
						hit4:
							begin
								state <= hit0;
								entering <= 1'b0;
								leaving <= 1'b0;
							end
						default:
							begin
								state <= hit0;
								entering <= 1'b0;
								leaving <= 1'b0;
							end
					endcase
			end
			
		end
		
	always @(state)
		begin
			if ( (state == hit4) && leaving)
				decrement <= 1'b1;
			else if ( (state == hit4) && entering)
				increment <= 1'b1;
			else
				{increment, decrement} <= 2'b00;
		
		end




endmodule
