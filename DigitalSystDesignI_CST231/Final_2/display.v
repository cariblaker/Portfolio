


module display(
	input rst,
	input [3:0] hours,
	input [5:0] mins,
	input [5:0] secs,
	output [6:0] seg_h_tens, seg_h_ones, seg_m_tens, seg_m_ones, seg_s_tens, seg_s_ones
);

	wire [7:0] bcd_h, bcd_m, bcd_s;


	bin2bcd #(4) U1(hours, bcd_h);
	bin2bcd #(7) U2(mins, bcd_m);
	bin2bcd #(7) U3(secs, bcd_s);
	
	seg_7 U4(bcd_h[7:4], rst, seg_h_tens);
	seg_7 U5(bcd_h[3:0], rst, seg_h_ones);
	seg_7 U6(bcd_m[7:4], rst, seg_m_tens);
	seg_7 U7(bcd_m[3:0], rst, seg_m_ones);
	seg_7 U8(bcd_s[7:4], rst, seg_s_tens);
	seg_7 U9(bcd_s[3:0], rst, seg_s_ones);


endmodule
