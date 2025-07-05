module shift_out(
	input clk,
	input ShR,
	input clr,
	input in,
	output reg [3:0]sum
);


reg [3:0]sum_reg;


always @(posedge clk)
	begin

		if (clr)
			sum <= 4'b0000;
		
		else if (ShR)
			sum <= {in, sum[3:1]};
			
		else
			sum <= sum;
	
	end
	
	

endmodule

