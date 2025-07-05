module flip_flop(
	input clk,
	input D,
	input clr,
	input set,
	output reg Q
);


always @(posedge clk or posedge set or posedge clr)
begin
	if (clr)
		Q <= 0;
	else if (set)
		Q <= 1;
	else
		Q <= D;

end

endmodule 