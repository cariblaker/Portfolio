module ShiftRegister(
	input [3:0]D,
	input sin,
	input load,
	input l_r,
	input clk,
	input reset,
	output [3:0]Q,
	output sout
);

	
		
	myShiftRegister ShiftReg1(D, sin, load, l_r, clk, reset, Q, sout);



endmodule
