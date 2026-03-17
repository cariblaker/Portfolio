module shift_reg_4b(
	input rst,
	input din,
	input clk,
	output reg [4:1]Q
);

	always @(posedge clk)
		begin
			
			if (rst)
				Q <= 4'b0000;
			
			else
				begin
					Q <= {din, Q[4:2]};
				
				end
			
		end		//end always



endmodule 