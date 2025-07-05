//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 2
//   Project: Intro to Heirarchical Design
//   File Name: Lab2.v
//   List of other files used: counter.v, clk_dv.v seg_7.v, bin2bcd.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this module divides clock time, and includes an asynchronous reset
//		
//-----------------------------------------------------------------------------    
//   Date: 01/17/2023
//   Version: 1.1
//		Revision: 
//			1/17/2023	- initial version
//			1/18/2023	- added comments & formatting
//							- added code for use of the new decode file/module
//							- deleted "decode", added bin2bcd & modifed for it
//-----------------------------------------------------------------------------

module Lab2(
	input clk,
	input rst,
	input ena,
	output [6:0]ones,
	output [6:0]tens,
	output [6:0]hundreds,
	output [6:0]thousands,
	output [6:0]ten_thousands
);

//-----------------------------------------------------------
// Signal Declarations: wire
//-----------------------------------------------------------
wire clk_1Hz;													//2 hz signal provided by clk_dv, used for counter
wire [15:0]count;			 								   //the number to be decoded for 7seg
wire [19:0]bcd;												//digits of count for the 7seg decoder

clk_dv #(25000000) U1(clk, rst, clk_1Hz);

counter U2(clk_1Hz, rst, ena, count);

bin2bcd #(16) U3(count, bcd);

seg_7 U4(bcd[3:0], ones); 
seg_7 U5(bcd[7:4], tens);
seg_7 U6(bcd[11:8], hundreds);
seg_7 U7(bcd[15:12], thousands); 
seg_7 U8(bcd[19:16], ten_thousands);


endmodule
