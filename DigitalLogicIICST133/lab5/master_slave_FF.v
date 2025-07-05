module master_slave_FF(
	input clk,
	input D,
	output Q
);
	 //W1 is Q output of first D latch, becomes D of second D latch
wire W1, W2, Q_not;
			//W2 is Q_not of first D latch, goes nowhere

gated_D_latch U1(D, ~clk, W1, W2);
gated_D_latch U2(W1, clk, Q, Q_not); //this Q_not also goes nowhere


endmodule 