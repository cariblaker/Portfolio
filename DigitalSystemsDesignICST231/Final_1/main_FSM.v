
module main_FSM(
	input clk, rst, b3, b2, b1, b0,
	input [2:0]left_in,
	input [5:0]haz_in,
	input [2:0]right_in,
	output reg L, H, R,
	output reg [5:0]lights
	);
	
//-----------------------------------------------------------
// Signal Declarations: localparam
//-----------------------------------------------------------
	localparam idle 	= 4'b0001;
	localparam hazard = 4'b0010;
	localparam left 	= 4'b0100;
	localparam right 	= 4'b1000;
	
//-----------------------------------------------------------
// Signal Declarations: reg
//-----------------------------------------------------------
	reg [3:0] state;
	
	
	initial
		begin
			lights <= 6'b000000;
			{L, H, R} <= 3'b000;
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

					casex ({b3, b2, b1, b0})
						4'bx1xx :	state <= hazard;
						4'b10x0 :	state <= left;
						4'b00x1 :	state <= right;
						default : 	state <= idle;
					endcase

				end
		
		end
		
		
		always @(state)												//output logic
			begin
			
				case (state)
				
					idle :
						begin
							{L, H, R} <= 3'b000;
							if (!b1)										//braking in idle
								lights <= 6'b111111;
							else
								lights <= 6'b000000;
						end
						
					hazard :
						begin
							{L, H, R} <= 3'b010;
							lights <= haz_in;							//no brakes allowed
						end
					
					left :
						begin
							{L, H, R} <= 3'b100;
							if (!b1)										//braking w/left signal
								lights <= {left_in, 3'b111};
							else
								lights <= {left_in, 3'b000};
						end
			
					right :
						begin
							{L, H, R} <= 3'b001;
							if (!b1)
								lights <= {3'b111, right_in};		//braking w/right signal
							else
								lights <= {3'b000, right_in};
						end
						
					default :
						begin
							{L, H, R} <= 3'b000;
							lights <= 6'b000000;
						end
						
					endcase
			
			end
		
endmodule
