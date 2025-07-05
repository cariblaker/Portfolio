module my_encoder(
	input enable,
	input [6:0]a,
	output [2:0]yout
);

wire y2, y1, y0;

assign yout[2] = enable ? 1'bz : y2;
assign yout[1] = enable ? 1'bz : y1;
assign yout[0] = enable ? 1'bz : y0;


assign y2 = ( a[6] | (~a[6] & a[5]) | (~a[6] & ~a[5] & a[4]) | (~a[6] & ~a[5] & ~a[4] & a[3]) );
assign y1 = ( a[6] | (~a[6] & a[5]) | (~a[6] & ~a[5] & ~a[4] & ~a[3] & a[2]) | (~a[6] & ~a[5] & ~a[4] & ~a[3] & ~a[2] & a[1]));
assign y0 = ( a[6] | (~a[6] & ~a[5] & a[4]) | (~a[6] & ~a[5] & ~a[4] & ~a[3] & a[2]) | (~a[6] & ~a[5] & ~a[4] & ~a[3] & ~a[2] & ~a[1] & a[0]) );



endmodule