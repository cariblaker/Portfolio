module jkflipflop(
    input j,
    input k,
    input set,
    input reset,
    input clk,
    output reg q,
    output reg qn
);


reg d;


always @(posedge set or posedge reset or posedge clk)
begin

	d = j & ~k;

	if (reset)
		q <= 1'b0;

	
	else if (set)
		q <= 1'b1;
	
	else
	begin

		q <= d;
		
	end

		qn <= ~q;
		
end


endmodule
