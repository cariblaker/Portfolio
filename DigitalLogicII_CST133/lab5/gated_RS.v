module gated_RS(
input S,
input clk,
input R,
output Q,
output Q_not

);



	wire W0, W1;

	assign W0 = ~(S & clk);
	assign W1 = ~(R & clk);

	assign Q = ~(W0 & Q_not);
	assign Q_not = ~(W1 & Q);




endmodule 