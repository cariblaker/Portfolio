module D_FF(
	input D,
	input clk,
	input aload,
	input aclr,
	output reg Q
);

//assuming the "a" in clr & load mean asynchronous

always @(posedge clk or posedge aclr or posedge aload)
begin

	if (aclr)		//clr takes priority
		Q <= 1'b0;
		
	else if (aload)	//load takes second priority
		Q <= 1'b1;
		
	else
		Q <= D;
			

end	//end always


endmodule
