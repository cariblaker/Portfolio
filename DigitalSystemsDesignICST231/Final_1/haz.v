
module haz(
	input clk,
	input rst,
	input ena,
	output reg [5:0]leds
);

//-----------------------------------------------------------
// Signal Declarations: reg
//-----------------------------------------------------------
	reg [8:0] count;
	

	initial
		begin
			leds <= 6'b000000;
			count <= 500;
		end
		
		
	always @(posedge clk or posedge rst)
		begin
		
			if (rst)
				begin
					leds <= 0;
					count <= 500;
				end
			
			else
				begin
					if (ena)
						begin
							if (count >= 500)
								begin
									leds <= ~leds;
									count <= 0;
								end
							else
								begin
									leds <= leds;
									count <= count + 1;
								end
						end
							
					else
						begin
							count <= 500;
							leds <= 6'b000000;
						end
				end
		
		end


endmodule
