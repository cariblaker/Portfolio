//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Midterm 2
//   Project: Car Lot Counter
//   File Name: BCD_ones.v
//   List of other files used: sensor_FSM.v, BCD_tens.v, seg_7.v, lot_counter.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		takes FSM's increment/decrement and counts up/down appropriately,
//		outputs ones to seven seg and up/down to tens digit of other BCD module
//-----------------------------------------------------------------------------    
//   Date: 03/02/2023
//   Version: 1.0
//-----------------------------------------------------------------------------


module BCD_ones(
	input rst,
	input inc,
	input dec,
	output reg up, down,
	output reg[3:0]count
);

//-----------------------------------------------------------
// Signal Declarations: reg
//-----------------------------------------------------------

	reg [3:0]num;							//register keeps track of count, separate from output logic
	reg go_up, go_down;					//keeps track of whether to signal BCD_tens up/down, separate from output logic

	
	initial
		begin
			num = 0;
			{go_up, go_down} = 2'b00;
		end

	
	always @(inc or dec or rst)
		begin
			if (rst)
				begin
					num = 0;
					{go_up, go_down} = 2'b00;
				end
			else 
				begin
				
					if (inc)
						begin
							if (num == 9)
								begin
									{go_up, go_down} = 2'b10;
									num = 0;
								end
							else
								begin
									{go_up, go_down} = 2'b00;
									num = num + 1;
								end
						end
					
					else if (dec)
						begin
							if (num == 0)
								begin
									{go_up, go_down} = 2'b01;
									num = 9;
								end
							else
								begin
									{go_up, go_down} = 2'b00;
									num = num - 1;
								end
						end
						
					else
						begin
							num = num;
							{go_up, go_down} = 2'b00;
						end
				end
		end

		
	always @(num or go_up or go_down)
		begin
			count = num;
			up = go_up;
			down = go_down;
		end
		
endmodule
