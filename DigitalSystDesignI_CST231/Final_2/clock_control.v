


module clock_control(
	input clk,
	input rst,
	input set, set_h, set_m,					
	output reg setting,
	output reg setting_h,						
	output reg setting_m							
);


	localparam run 			= 3'b001;
	localparam change_hrs 	= 3'b010;
	localparam change_mins 	= 3'b100;

	
	reg [2:0] state;

	
	initial
		begin
			setting_h <= 0;
			setting_m <= 0;
			setting <= 0;
			state <= run;
		end

	
	always @(posedge clk)
		begin
			
			casex (state) 																//active low buttons
				run :	
					begin
						if (!set && !set_h)
							state <= change_hrs;
						else if (!set && !set_m)
							state <= change_mins;
						else
							state <= state;
					end

				change_hrs :
					begin
						if (set)
							state <= run;
						else if (!set && !set_m)
							state <= change_mins;
						else 
							state <= state;
					end
					
				change_mins :
					begin
						if (set)
							state <= run;
						else if (!set && !set_h)
							state <= change_hrs;
						else
							state <= state;
					end
				
				default : 	state <= run;
			endcase
		
		end
		
	always @(posedge clk or posedge rst)
		begin
		
			if (rst)
				begin
					{setting, setting_h, setting_m} <= 3'b000;
				end
				
			else
				begin
				
					case (state)
						run 			: {setting, setting_h, setting_m} <= 3'b000;
						change_mins : {setting, setting_h, setting_m} <= 3'b101;
						change_hrs 	: {setting, setting_h, setting_m} <= 3'b110;
						default 		: {setting, setting_h, setting_m} <= 3'b000;
					endcase
					
				end
		
		end


endmodule
