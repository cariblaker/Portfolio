module Johnson_Counter(
	input hold,
	input reset,
	input clk,
	output reg [4:0]count
);



	always @(posedge clk or posedge reset)
	begin
		if (reset)
			count <= 5'b00000;
		else if (hold)
			count <= count;
		else
			case(count)
				5'b00000 : count <= 5'b00001;
				5'b00001 :  count <= 5'b00011;
				5'b00011 : count <= 5'b00111;
				5'b00111 : count <= 5'b01111;
				5'b01111 : count <= 5'b11111;
				5'b11111 : count <= 5'b11110;
				5'b11110 : count <= 5'b11100;
				5'b11100 : count <= 5'b11000;
				5'b11000 : count <= 5'b10000;
				5'b10000 : count <= 5'b00000;
				default : count <= 5'b00000;
			endcase
	
	end
	


endmodule
