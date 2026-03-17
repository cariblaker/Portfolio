module lock_mechanism (
	input clk,
	input reset,
	input enable,
	input [15:0]code,
	output reg error,
	output reg unlocking,
	output reg open

);


	reg [1:0]	state;
	reg [10:0]	count;
	reg [15:0]	code_hold;
	
	localparam idle 	= 2'b00;
	localparam check 	= 2'b01; 
	localparam unlock = 2'b11;
	localparam relock = 2'b10;

	localparam code_one 		= 16'h1234;
	localparam code_two 		= 16'hABCD;
	localparam code_three	= 16'h1122;
	localparam code_four 	= 16'h1010;
	localparam code_five 	= 16'h123A;
	localparam code_six 		= 16'h2580;


	always @(posedge clk)										//state transition logic
		begin
			if(reset)
				begin 
					state <= idle;
				end
			else 
				begin
					case (state)
						idle:
							begin
								if (enable)
									begin
										code_hold <= code;
										state <= check;
									end
								else
									begin
										state <= state;
									end
							end
							
						check: 
							begin 							
								if (count < 1250)
									begin
										count <= count + 1;
									end
								else
									begin
										if (code_hold == code_one || code_hold == code_two || code_hold == code_three || code_hold == code_four || code_hold == code_five || code_hold == code_six)
											begin
												state <= unlock;
												count <= 0;
											end
										else
											begin
												state <= relock;
												count <= 0;
											end

									end
								end
							
						unlock:
							begin
								if (count < 1250)							//keep LED lit for 5 seconds
									begin
										count <= count + 1;
									end
									
								else
									begin
									state <= idle;
									count <= 0;
									end
							end
							
						relock:
							begin
								if (count < 1250)							//keep LED lit for 5 seconds
									begin
										count <= count + 1;
									end
										
								else
									begin
										state <= idle;
										count <= 0;
									end
							end
						
						default:
							state <= idle;
					endcase
				end
		end
		
		
	always @(posedge clk)								//state outputs
		begin 
			case (state)
				idle:
					begin
						error = 0;
						open = 0;
						unlocking = 0;
					end
				check: 
					begin
						error = 0;
						open = 0;
						unlocking = 1;
					end			
				unlock:
					begin
						error = 0;
						open = 1;
						unlocking = 0;
					end			
				relock:
					begin
						error = 1;
						open = 0;
						unlocking = 0;
					end	
				default:
					begin
						error = 0;
						open = 0;
						unlocking = 0;
					end	
				endcase
		end


endmodule 