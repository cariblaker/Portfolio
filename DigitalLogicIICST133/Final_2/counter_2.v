

//this one continues counting as if the previous number was its own code


module counter_2(
	input updn,
	input m,
	input cen,
	input rst,
	input clk,
	output reg [2:0]Q
);

	parameter init = 3'b000, g1 = 3'b001, g2 = 3'b011, g3 = 1'b010, g4 = 3'b110, g5 = 3'b111, g6 = 3'b101, g7 = 3'b100;
	
	reg [2:0]state;
	
	initial
	begin
	
		state <= init;
	
	end
	
	 
	 always @(posedge clk or posedge rst)
	 begin
	 
		if (rst)
			state <= init;
	 
		else if (~cen)
			state <= state;
		
		else
		begin
		
			if (~m)	//binary
			begin
			
				if (updn)
					state <= state + 1;
				else
					state <= state - 1;
			end //end ~m
			
			else		//gray
			begin
			
				if (updn)	//up
				begin
				
					case (state)
						init : state <= g1;
						g1	  : state <= g2;
						g2	  : state <= g3;
						g3	  : state <= g4;
						g4	  : state <= g5;
						g5	  : state <= g6;
						g6	  : state <= g7;
						g7	  : state <= init;
					endcase	//gray up state
					
				end		//up gray end
				
				else		//gray down
				begin
				
					case (state)
						init : state <= g7;
						g1	  : state <= init;
						g2	  : state <= g1;
						g3	  : state <= g2;
						g4	  : state <= g3;
						g5	  : state <= g4;
						g6	  : state <= g5;
						g7	  : state <= g6;
					endcase	//gray down state
					
				end		//end gray down
				
			end		//end gray else
		
		end		//end encompassing else
	 
	 end		//end always
	 
	 
	 
	 
	 always @(state)
	 begin

			Q <= state;

	 end
	


endmodule 