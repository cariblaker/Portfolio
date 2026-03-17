module shift_data(
	input clk,
	input clr,
	input ShR,
	input load,
	input [3:0]data,
	output reg out
);

reg [3:0]shift;

initial
	begin
	
		shift <= data;
	
	end


always @(posedge clk)
	begin
		
		if (clr)
			shift <= data;							//dunno if data should be loaded into shift only when load is high? but if load stays high then... the shift won't move if shr is high... toughy
			
		else if (ShR)
			shift <= {shift[0], shift[3:1]};
			
		else
			shift <= shift;
		
	end
	
	
	
always @(posedge clk)
	begin
	
		if (clr)
			out <= 1'b0;
	
		else if (load)
			out <= shift[0];
			
		else
			out <= out;
	
	
	end


endmodule
