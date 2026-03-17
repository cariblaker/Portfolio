//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Midterm 2
//   Project: Car Lot Counter
//   File Name: BCD_tens.v
//   List of other files used: sensor_FSM.v, BCD_ones.v, seg_7.v, lot_counter.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		takes BCD_one's up/down and counts up/down appropriately,
//		outputs tens number to seven seg
//-----------------------------------------------------------------------------    
//   Date: 03/02/2023
//   Version: 1.0
//-----------------------------------------------------------------------------


module BCD_tens(
	input rst,
	input inc,
	input dec,
	output reg [3:0]num
);


	initial
		begin
			num = 0;
		end
	
	always @(inc or dec or rst)
		begin
		
			if (rst)
				begin
					num = 0;
				end
				
			else if (inc)
				begin
					if (num == 9)
						num = 0;
					else
						num = num + 1;
				end
				
			else if (dec)
				begin
					if (num == 0)
						num = 9;
					else
						num = num - 1;
				end
				
			else
				num = num;
		end


endmodule
