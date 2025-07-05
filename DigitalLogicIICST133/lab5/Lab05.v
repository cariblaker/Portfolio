module Lab05(
input reset,
input set,
input clk,
input D,
output [2:0]rslatch_Q, //even numbered wires
output [2:0]rslatch_Q_not, //odd numbered wires
output dlatch_Q,
output dlatch_Q_not,
output ms_dlatch,
output dstorage
);



wire W1 = reset;
wire W2 = set;
wire W3, W4, W5, W6, W7, W8;

RS_latch latch_struc(W1, W2, W3, W4);
RS_latch_DF latch_DF(W1, W2, W5, W6);
gated_RS g_RS(W2, clk, W1, W7, W8);
gated_D_latch g_D(D, clk, dlatch_Q, dlatch_Q_not);
master_slave_FF MS_FF(clk, D, ms_dlatch);
dstorage D_stor(clk, D, dstorage);

assign rslatch_Q = {W3, W5, W7};
assign rslatch_Q_not = {W4, W6, W8};



endmodule
