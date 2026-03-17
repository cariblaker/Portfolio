//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 2
//   Project: Intro to Heirarchical Design
//   File Name: counter.v
//   List of other files used: clk_dv.v, Lab2.v, seg_7.v, bin2bcd.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this file is a simple 16 bit counter (counts up!)
//		it has an asynchronous reset, and an enable. Added Parameter.
//-----------------------------------------------------------------------------    
//   Date: 01/17/2023
//   Version: 1.0
//		Revisions:
//		1/18/2023	-	added parameter
//-----------------------------------------------------------------------------


module counter
	#(parameter BIT_COUNT = 16) (
	input clk,
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
					cnt <= cnt + 1;
				
				else
					cnt <= cnt;
				
			end

	end


endmodule
