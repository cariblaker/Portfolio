


module hours_counter(
	input seconds_clk,
	input rst,
	input set,
	input [5:0] minutes,
	input [5:0] seconds,
	output reg [5:0] hours
);

	
	initial
		begin
		
			hours <= 12;
		
		end

		
		
	always @(posedge seconds_clk or posedge rst)
		begin
		
			if (rst)
				begin
					hours <= 12;
				end
				
			else
				begin
				
					case (set)
					
						1'b0 :
							begin
								if (minutes < 59)
									begin
										hours <= hours;
									end
								else
									begin
										if (seconds < 59)
											hours <= hours;
										else
											begin
												if (hours < 12)
													hours <= hours + 1;
												else
													hours <= 1;
											end
									end
							end
						
						1'b1 :
							begin
								if (hours < 12)
									hours <= hours + 1;
								else
									hours <= 1;
							end
							
						default :
							begin
								hours <= hours;
							end
							
					endcase
					
				end
		
		end
		
endmodule

