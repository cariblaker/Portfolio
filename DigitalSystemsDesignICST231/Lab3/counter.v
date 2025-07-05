//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 3
//   Project: Multiplexed Display
//   File Name: counter.v
//   List of other files used: Lab3.v, seg_7.v, back_end.v, bin2bcd.v
//		decoder.v, mux.v, control.v, front_end.v, top_level.v, clk_dv.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this file is a simple (paramaterized) 12 bit up/down counter
//		with an asynchronous reset and an enable. 
//-----------------------------------------------------------------------------    
//   Date: 01/25/2023
//   Version: 1.0
//		Revisions:
//		1/25/2023	-	initial setup
//		1/28/2023	-  added comments
//-----------------------------------------------------------------------------


module counter
	#(parameter BIT_COUNT = 12) (
	input clk,
	input updn,
	input rst,
	input ena,
	output reg [BIT_COUNT - 1 :0]cnt
);

initial
	begin
		cnt <= 0;
	end

always @ (posedge clk or posedge rst)		//asynch reset
	begin

		if (rst)
			cnt <= 0;
		
		else
			begin
	
				if (ena)
					begin
					
						case(updn)
							0: cnt <= cnt - 1;
							1: cnt <= cnt + 1;
						endcase
						
					end
					
				else
					cnt <= cnt;
				
			end

	end


endmodule
