//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 1
//   Project: Intro to DE1-SoC board 
//   File Name: Lab1.v
//   List of other files used: adder.v, Lab1.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this file takes the BCD number in, and outputs two digits coded for
//		seven segment display
//-----------------------------------------------------------------------------    
//   Date: 01/11/2023
//   Version: 1.0
//-----------------------------------------------------------------------------



module segment_7(
     input [4:0]num,
     output reg [6:0]dig_1,
	  output reg [6:0]dig_2
);
     

 always @(num)
    begin
	 
        case (num) 
            0 : 
					begin
						dig_1 = 7'b1000000;
						dig_2 = 7'b1000000;
					end
            1 : 
					begin
						dig_1 = 7'b1111001;
						dig_2 = 7'b1000000;
					end
            2 : 
					begin
						dig_1 = 7'b0100100;
						dig_2 = 7'b1000000;
					end
            3 : 
					begin
						dig_1 = 7'b0110000;
						dig_2 = 7'b1000000;
					end
            4 : 
					begin
						dig_1 = 7'b0011001;
						dig_2 = 7'b1000000;
					end
            5 : 
					begin
						dig_1 = 7'b0010010;
						dig_2 = 7'b1000000;
					end
            6 : 
					begin
						dig_1 = 7'b0000010;
						dig_2 = 7'b1000000;
					end
            7 : 
					begin
						dig_1 = 7'b1111000;
						dig_2 = 7'b1000000;
					end
            8 : 
					begin
						dig_1 = 7'b0000000;
						dig_2 = 7'b1000000;
					end
            9 : 
					begin
						dig_1 = 7'b0010000;
						dig_2 = 7'b1000000;
					end
            10 :
					begin
						dig_1 = 7'b1000000; 
						dig_2 = 7'b1111001;
					end
				11 :
					begin
						dig_1 = 7'b1111001;
						dig_2 = 7'b1111001;
					end
				12 :
					begin
						dig_1 = 7'b0100100;
						dig_2 = 7'b1111001;
					end
				13 :
					begin
						dig_1 = 7'b0110000;
						dig_2 = 7'b1111001;
					end
				14 :
					begin
						dig_1 = 7'b0011001;
						dig_2 = 7'b1111001;
					end
				15 :
					begin
						dig_1 = 7'b0010010;
						dig_2 = 7'b1111001;
					end
				16 :
					begin
						dig_1 = 7'b0000010;
						dig_2 = 7'b1111001;
					end
				17 :
					begin
						dig_1 = 7'b1111000;
						dig_2 = 7'b1111001;
					end
				18 :
					begin
						dig_1 = 7'b0000000;
						dig_2 = 7'b1111001;
					end
				19 :
					begin
						dig_1 = 7'b0010000;
						dig_2 = 7'b1111001;
					end
				20 :
					begin
						dig_1 = 7'b1000000;
						dig_2 = 7'b0100100;
					end
				21 :
					begin
						dig_1 = 7'b1111001;
						dig_2 = 7'b0100100;
					end
				22 :
					begin
						dig_1 = 7'b0100100;
						dig_2 = 7'b0100100;
					end
				23 :
					begin
						dig_1 = 7'b0110000;
						dig_2 = 7'b0100100;
					end
				24 :
					begin
						dig_1 = 7'b0011001;
						dig_2 = 7'b0100100;
					end
				25 :
					begin
						dig_1 = 7'b0010010;
						dig_2 = 7'b0100100;
					end
				26 :
					begin
						dig_1 = 7'b0000010;
						dig_2 = 7'b0100100;
					end
				27 :
					begin
						dig_1 = 7'b1111000;
						dig_2 = 7'b0100100;
					end
				28 :
					begin
						dig_1 = 7'b0000000;
						dig_2 = 7'b0100100;
					end
				29 :
					begin
						dig_1 = 7'b0010000;
						dig_2 = 7'b0100100;
					end
				30 :
					begin
						dig_1 = 7'b1000000;
						dig_2 = 7'b0110000;
					end
            default : 
					begin
						dig_1 = 7'b1111111;
						dig_2 = 7'b1111111;	
					end
					
        endcase
		  
    end
    
	 
endmodule
