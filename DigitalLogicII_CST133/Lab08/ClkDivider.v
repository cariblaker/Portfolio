module ClkDivider(
	input clk,
	input reset,
	output reg clk_out
);
	
	reg [24:0] count;
	
	always @(posedge clk or negedge reset)
	begin
	
		if (~reset)
			count <= 25'b0;
		else if (count < 25000000 - 1)
			count <= count + 1;
		else
			count <= 25'b0;
		
	end
	
	
	always @(posedge clk or negedge reset)
	begin
	
		if (~reset)
			clk_out <= 1'b0;
		else if (count == 25000000 - 1)
			clk_out <= ~clk_out;
		else
			clk_out <= clk_out;
			
	end
		






endmodule
