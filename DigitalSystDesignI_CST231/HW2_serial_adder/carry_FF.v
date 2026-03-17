
module carry_FF(
	input clk,
	input clr,
	input cin,
	output reg cout
);


always @(posedge clk)
	begin
	
		if (clr)
			cout <= 1'b0;
			
		else
			cout <= cin;
	
	end


endmodule
