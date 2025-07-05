module johnson(
	input cen,
	input ud,
	input rst,
	input clk,
	output reg [4:0]Q
);
	
	
	
	initial
	begin
		Q = 5'b00000;		//set count's initial value to 0
	end
		
		
	
	always @(negedge clk or posedge rst)
	begin
		
		if (rst)		
		begin
				Q = 5'b00000;		//resets count
		end
					
		else		//if NOT reset...
		begin
		
			if (cen)		//and the clock is enabled...
			begin
			
				if (ud)
					Q = Q + 1;
					
				else if (~ud)
					Q = Q - 1;
//				case(ud)
////					1'b0 :`Q <= Q - 1;
////					1'b1 : Q <= Q + 1;
//				endcase
				
			end		//end cen if
			
		end			//end if not reset
		
	end			//end always
	
	






endmodule
