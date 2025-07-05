module Lab4(

	input [3:0]a,
	input [3:0]b,
	output [6:0]LSB,
	output [6:0]MSB

);

wire [7:0] connect;


myBCDAdder BCD(a, b, connect);

myBCDto7Seg LSBs(connect[3:0], LSB);
myBCDto7Seg MSBs(connect[7:4], MSB);



endmodule
