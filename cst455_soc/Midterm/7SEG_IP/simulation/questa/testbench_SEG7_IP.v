`timescale 1ns / 1ps

module testbench_SEG7_IP ();

    wire [31:0] readdata;
    reg [31:0] writedata;
    reg [1:0] address;
    reg chipselect;
    reg clk;
    reg reset_n;
	 reg read;
    reg write;
    wire [6:0] seg_out;
	 
	 SEG7_IP	UUT1 (address, chipselect, clk, reset_n, write, read, writedata, seg_out, readdata);
	 
	 always
		begin
			#10 clk <= ~clk;
		end
		
	initial
		begin
			clk <= 1'b0;
			writedata <= 32'h00000000;
			address <= 2'b0;
			chipselect <= 0;
			read <= 1'b0;
			write <= 1'b0;
			reset_n <= 1'b0;
			#15 reset_n <= 1;
			#5  chipselect <= 1'b1;
			#7  write <= 1'b1;
				 chipselect <= 1'b0;
			#10 write <= 1'b0;
			#5  chipselect <= 1'b1;
			#7  write <= 1'b1;
				 chipselect <= 1'b0;
			#10 write <= 1'b0;
			#40 chipselect <= 1'b1;
			#2 reset_n <= 1'b0;
			#20 chipselect <= 1'b0;
			#5 reset_n <= 1'b1;
			#30 reset_n <= 1'b0;
			#20 reset_n <= 1'b1;
			#20 chipselect <= 1'b1;
			#7  write <= 1'b1;
			#100 reset_n <= 1'b0;
			#30 reset_n <= 1'b1;
			
		end
		
	always @(posedge clk or negedge reset_n)
		begin
			writedata <= writedata + 1;
			if (writedata >= 12)
				writedata <= 32'h00000000;
		end
endmodule