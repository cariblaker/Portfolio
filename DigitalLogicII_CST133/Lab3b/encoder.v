module encoder(
input [3:0]a,
input ena,
output r0, r1, valid
);


wire [4:0]w;
wire x;

assign w[0] = ~a[3] & ~a[2] & ~a[1] & ~a[0];
assign w[1] = ~a[3] & ~a[2] & ~a[1] & a[0];
assign w[2] = ~a[3] & ~a[2] & a[1];
assign w[3] = ~a[3] & a[2];
assign w[4] = a[3];

assign valid = ena ? ena : w[0];

assign r0 = ena ? ~ena : w[3] | w[4];
assign r1 = ena ? ~ena : w[2] | w[4];

endmodule