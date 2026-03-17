module myShiftRegister(
	input [3:0]D,
	input sin,
	input load,
	input l_r,
	input clk,
	input reset,
	output reg [3:0]Q,
	output reg sout
);


	reg [3:0]shifty;
	
	
	always @(posedge clk or posedge reset)
		begin
			
			if (reset)
				shifty <= 4'b0000;		//resets register
			
			else
				begin
				
					if (load)
						shifty <= D;		//loads register
							
					else
						begin
						
							if (sin)
								begin
									if (l_r)
										begin
										
											sout <= shifty[3];
											shifty <= {shifty[2:0], 1'b0}; //shifts left for high l_r and stores overflow into sout
											
										end			//end l_r if
									else
										begin
										
											sout <= shifty[0];
											shifty <= {1'b0, shifty[3:1]};	//shifts right for low l_r and sout still gets other direction overflow	
											
										end			//end l_r else
														
								end
								
						end			//end load's else
			
				end				//end encompassing else
		
		end						//end always
		
		
		
	always @(posedge clk or posedge reset)
		begin
			
			Q <= shifty;
			
		end

		
		

endmodule
