`timescale 1ns / 1ps

module sev_seg_decoder_tb();
	 reg clk;
    reg [3:0] input_bin;          
    wire [6:0] display;           

    // Instantiate the Unit Under Test (UUT)
    sev_seg_decoder UUT (
        .input_bin(input_bin),    
        .display(display)         
    );
	 
	 always
		begin
			#10 clk <= ~clk;
		end

    initial begin
        // Monitor the input and output signals in the simulation console
        $monitor("Time = %0t, input_bin = %b, display = %b", $time, input_bin, display);

        // Test all possible values of the input (0-15 in binary)
        input_bin = 4'b0000; #10;   // Testing 0
        input_bin = 4'b0001; #10;   // Testing 1
        input_bin = 4'b0010; #10;   // Testing 2
        input_bin = 4'b0011; #10;   // Testing 3
        input_bin = 4'b0100; #10;   // Testing 4
        input_bin = 4'b0101; #10;   // Testing 5
        input_bin = 4'b0110; #10;   // Testing 6
        input_bin = 4'b0111; #10;   // Testing 7
        input_bin = 4'b1000; #10;   // Testing 8
        input_bin = 4'b1001; #10;   // Testing 9
        input_bin = 4'b1010; #10;   // Testing A
        input_bin = 4'b1011; #10;   // Testing B
        input_bin = 4'b1100; #10;   // Testing C
        input_bin = 4'b1101; #10;   // Testing D
        input_bin = 4'b1110; #10;   // Testing E
        input_bin = 4'b1111; #10;   // Testing F
    end

endmodule
