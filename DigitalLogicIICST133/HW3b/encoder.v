module encoder(
	input [9:0]a,
	output reg [3:0]y
);

	integer i;
	reg [3:0]i_reg;
	
	always @(a)
	begin
		for (i = 0; i < 10; i = i + 1) 
		begin
			if (a[i])
				y = i;
		end		//if
	end		//always


endmodule