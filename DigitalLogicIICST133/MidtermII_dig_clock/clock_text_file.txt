module dig_clock_counter(
	input clk,
	input reset,
	output reg ten_cnt,
	output reg [2:0]one_cnt

);

	initial			//starts the clock at 12:00
		begin
			ten_cnt <= 1'b1;
			one_cnt <= 3'b010;
		end


	always @(posedge clk)
		begin
	
			if (reset)
				begin
					
					ten_cnt <= 1'b1;
					one_cnt <= 3'b010;			//resets the clock hour to 12:00
				
				end		//end if reset
				
			else
				begin
					
					if (ten_cnt == 1'b1)		//if count is 10 thru 12
						begin
						
							if (one_cnt <= 3'b010)
								one_cnt <= one_cnt + 1'b1;		//if 10 or 11, count one up
								
							else										//if 12, go to 1 again
								begin
								
									ten_cnt <= 1'b0;
									one_cnt <= 3'b001;
									
								end					//end 1 again else
								
						end						//end 10 thru 12 case
					
					
					else						//if count is 1 thru 9
						begin
							
							if (one_cnt < 3'b111)		//if it's not 9 yet
								one_cnt <= one_cnt + 1'b1;
								
							else
								begin
								
									ten_cnt <= 1'b1;		//it's 10 now!
									one_cnt <= 3'b000;
								
								end				//end it was 9 now it's 10
						
						
						end				//end 1 thru 9 else
					
				
				end		//end if NOT reset
	
		end				//end always




endmodule 