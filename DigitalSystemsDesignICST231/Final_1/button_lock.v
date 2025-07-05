module button_lock(
	input clk,
	input rst,
	input button,
	output reg signal
);

//-----------------------------------------------------------
// Signal Declarations: localparam
//-----------------------------------------------------------
	
	localparam idle 		= 2'b00;
	localparam pressed 	= 2'b01;
	localparam unpressed = 2'b11;
	
//-----------------------------------------------------------
// Signal Declarations: reg
//-----------------------------------------------------------
	reg [1:0] state;
	reg button_pressed;


	initial
		begin
			signal <= 1'b0;
			state <= idle;
		end
		
		
	always @(posedge clk or posedge rst)
		begin
			if (rst)
				begin
					state <= idle;
				end
			else
				begin
					case (state)
						idle :
							begin
								if (!button)
									state <= pressed;
								else
									state <= state;
							end
						pressed :
							begin
								state <= unpressed;
							end
						unpressed :
							begin
								if (button)
									state <= idle;
								else
									state <= state;
							end
						default :
							begin
								state <= idle;
							end
					endcase
					
				end
				
		end
		
		
		always @(state or rst)
			begin
				if (rst)
					begin
						signal <= 1'b0;
					end
					
				else
					begin
			
						case (state)
							idle 			: signal <= signal;
							pressed 		: signal <= ~signal;
							unpressed 	: signal <= signal;
							default 		: signal <= signal;
						endcase
						
					end
			
			end
		
endmodule

