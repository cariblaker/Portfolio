module dff_neg_BH(
	input d,
	input clk,
	output reg q
);
	
	always @(negedge clk)
	begin
		q <= d;
	end
	
endmodule 