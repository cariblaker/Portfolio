//   Class: CST 231
//   Author: Cari Blaker
//   Lab: Lab 4
//   Project: Intro to Heirarchical Design
//   File Name: Lab4.v
//   List of other files used: clk_dv.v, seg_7.v, keypad_decode.v,
//					lockout.v, input_code.v, lock_mechanism.v
//-----------------------------------------------------------------------------    
//   Description of the Code 
//		this module is a higher level that puts together the keypad ins/outs
//-----------------------------------------------------------------------------    
//   Date: 2/1/2023
//   Version: 1.1
//		Revision: 
//			2/1/23	- initial version
//			2/4/23	- changed clock divide parameter several times, trial & error
//							added clock to U3
//			2/5/23	- added one-hot counter, removed "keypad" module, adjusted
//							inputs and outputs of this module and instantiated modules
//							parameter for clock changed, removed clock from Decoder
//			2/8/23	- removed counter, enable module, fixed inputs for keypad decoder
//			2/9/23	- removed keypad decoder, fixed inputs
//			3/13/23	- added lock mechanism, lockout, and input code modules,
//							removed reset inputs, wires for connection, adjusted top
//							level ins/outs
//-----------------------------------------------------------------------------
 


module keypad_lock(
	input clk,
	input [3:0] columns,					//GPIO_1[1][3][5][7]
	output [3:0] rows,					//GPIO_0[1][3][5][7]
	//output [6:0] HEX3,
	//output [6:0] HEX2,
	//output [6:0] HEX1,
	output [6:0] HEX0,
	output error							//LED9
	//output unlocking,						//LED1
	//output open								//LED0
);

 
	wire key_pressed, clk_250hz, P, start;
	wire [3:0] key;
	wire [15:0] code_out;
	wire [3:0] seg_out;

	clk_dv #(1250000) U1(clk, clk_250hz);  

	keypad_decode U2(clk_250hz, columns, rows, seg_out[3:0], error);//key, key_pressed);

	//lockout U3(clk_250hz, key_pressed, P);

	//input_code U4(clk_250hz, P, key, seg_out, code_out, start);

	//lock_mechanism U5(clk_250z, start, code_out, error, unlocking, open);

	//seg_7 U6(seg_out[15:12], HEX3);
	//seg_7 U7(seg_out[11:8], HEX2);
	//seg_7 U8(seg_out[7:4], HEX1);
	seg_7 U9(seg_out[3:0], HEX0);



endmodule

