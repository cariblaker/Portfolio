//--------------------------------------------------------------------------------
//Univeristy: Oregon Institute of Technology
//class: CST 231 
//Author: Ismael Hernandez-Hernandez
//Lab: Lab 4 
//Project: 
//File name: seven_seg.v
//List of other files: 
//--------------------------------------------------------------------------------
//
//--------------------------------------------------------------------------------
//Date: 1/20/2021
//Version 1.0 
//--------------------------------------------------------------------------------
module seven_seg(
	input [3:0]digit,
	output reg [6:0]segments
);

always @(digit)
	begin
		
		
			case (digit)
				4'b0000 :
					begin
						segments = 7'b0000001;
					end
				
				4'b0001 :   
					begin
						segments = 7'b1001111;
					end
				
				4'b0010 :   
					begin
						segments = 7'b0010010;
					end
					
				4'b0011 : 	
					begin
						segments = 7'b0000110;
					end
				
				4'b0100 :	
					begin
						segments = 7'b1001100;
					end
				
				4'b0101 :	
					begin
						segments = 7'b0100100;
					end
						
				4'b0110 :	
					begin
						segments = 7'b0100000;
					end
				
				4'b0111 :	
					begin
						segments = 7'b0001111;
					end
				
				4'b1000 :   
					begin
						segments = 7'b0000000;
					end
				
				4'b1001 :   
					begin
						segments = 7'b0000100;
					end
					
					
				4'b1010 :   
					begin
						segments = 7'b0001000 ;
					end
				
				4'b1011 :   
					begin
						segments = 7'b1100000;
					end	
				4'b1100 :   
					begin
						segments = 7'b0110001 ;
					end	
				4'b1101 :   
					begin
						segments = 7'b1000010 ;
					end	
				default : 	
					begin
						segments <= 7'b1111110;
					end
			endcase
	end
	
endmodule 
