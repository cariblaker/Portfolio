module myMOD10Counter(
	input up_dn,
	input cen,
	input clk,
	input reset,
	output reg [3:0]Q
);


reg [3:0]count;


	always @(negedge clk or posedge reset)
		begin
		
			if (reset)
				count <= 4'b0000;				//reset takes precedence
				
			else
				begin
				
					if (cen)					//if counting is not enabled, count stays the same
						count <= count;
					
					else
						begin
						
							if (up_dn)
								count <= (count < 4'b1001) ? (count + 1'b1) : (4'b0000);		//if we're not to 9 yet, count up, otherwise back to 0
								
							else
								count <= (count < 4'b0001) ? (4'b1001) : (count - 1'b1);		//count down, unless we're already at 0, then we can go back to 9
						
						end 		//end cen else
						
				end 			//end encompassing else
	
		end			//end always


	always @(negedge clk or posedge reset)
		begin
			
			Q <= count;
			
		end



endmodule 