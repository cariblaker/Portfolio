module traffic_fsm(
	input clk,
	input sen,
	input reset,
	output reg [2:0]highway,
	output reg [2:0]farmroad
);


	reg [2:0]count; 
	
	reg [1:0]state;
	
	
	parameter [1:0] 
		stateA = 2'b00,
		stateB = 2'b01,
		stateC = 2'b10,
		stateD = 2'b11;
		
	
	parameter [2:0]
		red = 3'b100,
		yellow = 3'b110,
		green = 3'b010,
		zero_count = 3'b000;
		
		
		
	initial
	begin
		
		state <= stateA;
	
	end
		
		

	
	
	always @(negedge reset or posedge clk)	//keeps track of count, transitions through states, resets
	begin
	
		if (~reset)	begin
			count <= zero_count;
			state <= stateA;
			end
	
		else begin
				
			if (~sen) begin
		
					case (state)
			
						stateA: begin
							if (count < 5)			//highway stays green at least 6 seconds before turning yellow
								count <= count + 1;
							else begin
								state <= stateB;
								count <= zero_count;	
							end
						end
							
						stateB: begin
							if (count < 3)			//highway yellow for 4 seconds
								count <= count + 1;
							else begin
								count <= zero_count;
								state <= stateC;
							end
						end
						
						stateC:	begin
							if (count < 5)				//highway red/farm green for 6 seconds
								count <= count + 1;
							else begin
								count <= zero_count;
								state <= stateD;
							end
						end
						
						stateD:	begin
							if (count < 3)				//farm yellow for 4 seconds
								count <= count + 1;
							else begin
								count <= zero_count;
								state <= stateA;
							end
						end	
						
						default: 	begin
							count <= zero_count;
							state <= stateA;
						end
						
					endcase 
			
			
			end			// end if ~sen
				
		end 			//end else (reset)
			
	end			//end always

	
	
	
	always @(state)		//controls outputs
	begin
		
		case (state)
		
			stateA: 	begin
				highway <= green;
				farmroad <= red;
			end
			
			stateB:	begin
				highway <= yellow;
				farmroad <= red;
			end
			
			stateC:	begin
				highway <= red;
				farmroad <= green;
			end
			
			stateD:	begin
				highway <= red;
				farmroad <= yellow;
			end
			
			default:	begin
				highway <= green;
				farmroad <= red;
			end
			
		endcase

		
	end	// end output always
	



endmodule
