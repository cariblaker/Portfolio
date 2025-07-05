module gated_D_latch(
input D,
input clk,
output Q,
output Q_not
);

	wire W1, W2;
	
	assign W1 = ~(D & clk);
	assign W2 = ~(~D & clk);
	assign Q = ~(W1 & Q_not);
	assign Q_not = ~(W2 & Q);


endmodule 
