module testbench_SW_IP();

	reg [1:0] address;
	reg chipselect;
	reg clk;
	reg read;
	reg reset_n;
	reg write;
	reg [31:0] writedata;
	reg [9:0] SW;
	wire [31:0] readdata;
	
	SW_IP UUT1 (address, chipselect, clk, read, reset_n, write, writedata, SW, readdata);
	
always 
	#10 clk <= ~clk;
	
initial
	begin
		clk <= 1'b1;
		chipselect <= 1'b1;
		address <= 2'b00;
		read <= 1'b0;
		reset_n <= 1'b0;
		writedata <= 31'h0000;
		write <= 1'b1;
		SW <= 10'b1111111111;
		#20 reset_n <= 1'b1;
		#15 SW <= 10'b1010101010;
		#10 write <= 1'b0;
		#10 SW <= 10'b1100110011;
		#20 write <= 1'b1;
	end
endmodule
