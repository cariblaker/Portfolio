
module question4(
	input [2:1]G,
	input sel,
	input en,
	output tout
);



my_modu U1(sx, a, b, m_out);

and U2(sx, G[1], G[2]);

nor U3(w1, m_out, sel);

notif1 U4(tout, w1, en);

endmodule