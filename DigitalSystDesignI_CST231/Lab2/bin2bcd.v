//-----------------------------------------------------------------------------    
//   University: Oregon Institute of Technology – CSET Department
//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 2
//   Project: Intro to Heirarchical Design
//   File Name: bin2bcd.v
//   List of other files used: counter.v, Lab2.v, clk_dv.v, seg_7.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this module converts a 16 digit BCD# to 5 digits of seven-segment display
//-----------------------------------------------------------------------------    
//   Date: 01/17/2023
//   Version: 1.0
//		Revision: 
//			1/18/2023	- created this file, for the module taken from Wikipedia,
//								 to replace the file I created that did not work doing
//								 division and modulus stuff
//-----------------------------------------------------------------------------


// from https://en.wikipedia.org/wiki/Double_dabble
// parametric Verilog implementation of the double dabble binary to BCD converter
// for the complete project, see
// https://github.com/AmeerAbdelhadi/Binary-to-BCD-Converter

module bin2bcd
 #( parameter   W = 18 )  		// input width
  ( input      [W-1      :0] bin,  				// binary
    output reg [W+(W-4)/3:0] bcd); 				// bcd {...,thousands,hundreds,tens,ones}

  integer i,j;

  always @(bin) begin
    for(i = 0; i <= W+(W-4)/3; i = i+1) bcd[i] = 0;     // initialize with zeros
    bcd[W-1:0] = bin;                                   // initialize with input vector
    for(i = 0; i <= W-4; i = i+1)                       // iterate on structure depth
      for(j = 0; j <= i/3; j = j+1)                     // iterate on structure width
        if (bcd[W-i+4*j -: 4] > 4)                      // if > 4
          bcd[W-i+4*j -: 4] = bcd[W-i+4*j -: 4] + 4'd3; // add 3
  end

endmodule
