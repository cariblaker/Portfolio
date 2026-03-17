module dlatch_BH(
	input d,
	input clk,
	output reg q
);


	always @(*)
		begin
			if (clk)
				q <= d;
		
		end
		
endmodule

		