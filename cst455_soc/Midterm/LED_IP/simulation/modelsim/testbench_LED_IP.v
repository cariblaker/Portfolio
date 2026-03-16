`timescale 1ns / 1ps

module testbench_LED_IP ();

    wire [31:0] readdata;
    reg [31:0] writedata;
    reg [1:0] address;
    reg chipselect;
    reg clk;
    reg reset_n;
    reg write;
    wire [9:0] led_out;
	 
	 LED_IP	UUT1 (address, chipselect, clk, reset_n, write, writedata, led_out, readdata);
	 
	 always
		#10 clk <= ~clk;
		
	initial
		begin
			clk <= 1'b0;
			writedata <= 32'h00000000;
			address <= 2'b0;
			chipselect <= 0;
			write <= 1'b0;
			reset_n <= 1'b0;
			#15 reset_n <= 1;
			#5  writedata <= 32'h000002aa;
			#5  chipselect <= 1'b1;
			#7  write <= 1'b1;
			#20 writedata <= 32'h00000000;
				 chipselect <= 1'b0;
				 write <= 1'b0;
			#40 writedata <= 32'h00000155;
			#5  chipselect <= 1'b1;
			#7  write <= 1'b1;
			#20 writedata <= 32'h000003ff;
				 chipselect <= 1'b0;
				 write <= 1'b0;
			#40 chipselect <= 1'b1;
			#20 chipselect <= 1'b0;
		end
endmodule
	
	 
	 