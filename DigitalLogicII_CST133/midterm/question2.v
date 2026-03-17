module question2(
	input A,
	input B,
	input C,
	input D,
	output F
);

assign F = ((A & B) | (C & ~D) | (~A & ~B & D) | (~A & ~C & D));
	


endmodule