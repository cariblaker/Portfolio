module counter(
	input clk,
	input set,
	input clr,
	output reg [2:0]Q
);

//I'm struggling with following the logic here...
//but if I'm interpreting this schematic correctly
//the only output bit that can possibly change from a 0 is Q[2]... when it's a 1, all the D's become 0's and the Q's follow again.
//I just built the other files in this project to make sure I had the logic right... and if I did the other logic correctly, then I know I didn't get this stuff right.
//but here's all of it--I have to go to work, but if I get off earlier than midnight tonight, hopefully I can resubmit.



always @(posedge clk or posedge set or posedge clr)
begin
	if (clr)
		Q <= 3'b000; 		//clear takes priority over set
	else if (set)
		Q <= 3'b100;
	else
		Q <= 3'b000;
end


endmodule
