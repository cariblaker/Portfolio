

module minutes_counter(
	input seconds_clk,
	input rst,
	input set,
	input [5:0] seconds,
	output reg [5:0] minutes
);

	
	initial
		begin
		
			minutes <= 0;
		
		end

		
		
	always @(posedge seconds_clk or posedge rst)
		begin
		
			if (rst)
				begin
					minutes <= 0;
				end
				
			else
				begin
				
					case (set)
					
						1'b0 :
							begin
								if (seconds < 59)
									begin
										minutes <= minutes;
									end
								else
									begin
										if (minutes < 59)
											minutes <= minutes + 1;
										else
											minutes <= 0;
									end
							end
						
						1'b1 :
							begin
								if (minutes < 59)
									minutes <= minutes + 1;
								else
									minutes <= 0;
							end
							
						default :
							begin
								minutes <= minutes;
							end
							
					endcase
					
				end
		
		end
		
endmodule

		