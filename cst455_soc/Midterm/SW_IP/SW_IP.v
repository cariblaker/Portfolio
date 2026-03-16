module SW_IP(
	input [1:0] address,
	input chipselect,
	input clk,
	input read,
	input reset_n,
	input write,
	input [31:0] writedata,
	input [9:0] SW,
	output reg [31:0] readdata
);

always @ (SW)
	begin
		readdata <= (SW | 32'h00000000);
	end

endmodule
