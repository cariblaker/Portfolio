

module seconds_counter(
	input clk,
	input rst,
	input set,
	output reg [5:0]seconds
);


	initial
		begin
		
			seconds <= 0;
		
		end
		
	always @(posedge clk or posedge rst)						//if timing is off with minutes or hours, may need to add second always block for outputs and make this one for counting
		begin
		
			if (rst)	
				begin
					seconds <= 0;
				end
			else
				begin
					case (set)
						0 :
							begin
								if (seconds < 59)
									seconds <= seconds + 1;

								else
									seconds <= 0;
							end
						1 :
							begin
								seconds <= seconds;							//pause the count if something's getting set
							end
						default :
							begin
								seconds <= seconds;
							end
					endcase	
				end

		end


endmodule
