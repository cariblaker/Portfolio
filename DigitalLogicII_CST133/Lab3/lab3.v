module lab3(
	input ena, 
	input p, 
	input [1:0]a, 
	output [3:0]y

);



decoder2x4 D1(ena, p, a, y);


endmodule