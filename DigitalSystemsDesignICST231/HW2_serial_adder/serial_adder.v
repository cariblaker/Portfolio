module serial_adder(
	input clk,
	input reset,
	input [3:0]DATAa,
	input [3:0]DATAb,
	output Cout,
	output [3:0]Sum
);

	wire aOut, bOut, cin, clr, ShR, load, done;


	adder_controller U1(clk, reset, clr, ShR, load, done);
	shift_data U2(clk, clr, ShR, load, DATAa, aOut);
	shift_data U3(clk, clr, ShR, load, DATAb, bOut);
	full_adder U4(aOut, bOut, Cout, sumBit, cin);
	carry_FF U5(clk, clr, cin, Cout);
	shift_out U6(clk, ShR, clr, sumBit, Sum);
	

endmodule
