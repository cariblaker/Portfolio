

module ampm(
	input clk,
	input rst,
	input set,
	input [3:0]hrs,
	input [5:0]mins,
	input [5:0]secs,
	output reg led
);

initial
	begin
		led <= 1'b1;
	end


always @(posedge clk or posedge rst)
	begin
	
		if (rst)
			led <= 1'b1;
			
		else
			begin
				if (set)
					begin
						if (hrs == 11)
							led <= ~led;
					end
				else
					begin	
						if (hrs == 11)
							begin
								if (mins == 59)
									begin
										if (secs == 59)
											led <= ~led;
									end
							end
						
						else
							begin
								led <= led;
							end
					end
			end
	
	end
	
	
endmodule
