//--------------------------------------------------------------------------------
//Univeristy: Oregon Institute of Technology
//class: CST 231 
//Author: Ismael Hernandez-Hernandez
//Lab: Lab 4 
//Project: Intro to Hierarchical design
//File name: clock_divider.v
//List of other files: 
//--------------------------------------------------------------------------------
//
//
//--------------------------------------------------------------------------------
//Date: 1/24/2021
//Version 1.0 
//--------------------------------------------------------------------------------
module clock_divider 
	#(parameter DIV = 25000000) 
	(input clk, 
	output reg out_clk);
	
reg [25:0] count;

initial begin
	out_clk = 0;
	count = 0;
end

 always @(posedge clk) begin
	count <= count + 1;
		if (count == DIV-1) begin
			out_clk <= ~out_clk;
			count <= 0;
		end
end

endmodule 