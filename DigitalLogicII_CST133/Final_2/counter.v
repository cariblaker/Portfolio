
//this problem could be interpreted in two ways...
//so I did it both ways.
//this module continues counting from the equivalent decimal number

module counter(
	input updn,
	input m,
	input cen,
	input rst,
	input clk,
	output reg [2:0]Q
);

	parameter init = 3'b000, g1 = 3'b001, g2 = 3'b011, g3 = 1'b010, g4 = 3'b110, g5 = 3'b111, g6 = 3'b101, g7 = 3'b100;
	
	reg [2:0]state;
	
	initial
	begin
	
		state <= init;
	
	end
	
	 
	 always @(posedge clk or posedge rst)
	 begin
	 
		if (rst)
			state <= init;
	 
		else if (~cen)
			state <= state;
		
		else
		begin
			case(updn)
				0 :	state <= state - 1;
				1 : 	state <= state + 1;
				
			endcase		// end m case 
		
		
		end		//end encompassing else
	 
	 end		//end always
	 
	 always @(state)
	 begin
	 
		if (~m)
			Q <= state;		//binary
			
		else begin		
		
			case (state)	//gray
				init : Q <= init;
				3'b001 : Q <= g1;
				3'b010 : Q <= g2;
				3'b011 : Q <= g3;
				3'b100 : Q <= g4;
				3'b101 : Q <= g5;
				3'b110 : Q <= g6;
				3'b111 : Q <= g7;
			endcase	//state case
			
		end	//end m gray
			
	 end	//always
	
	



endmodule 