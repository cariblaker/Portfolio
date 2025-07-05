module RS_latch_DF(
input R,
input S,
output Q,
output Q_not
);


assign Q = ~(R | Q_not);
assign Q_not = ~(S | Q);


endmodule
