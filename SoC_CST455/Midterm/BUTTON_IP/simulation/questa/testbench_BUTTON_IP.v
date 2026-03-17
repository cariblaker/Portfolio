`timescale 1ns / 1ps

module testbench_BUTTON_IP ();

    wire [31:0] readdata;
    reg [31:0] writedata;
    reg [1:0] address;
    reg chipselect;
    reg clk;
    reg reset_n;
    reg read;
    reg write;
    reg [3:0] button_in; // 4-bit input for four buttons

    // Instantiate the BUTTON_IP module with 4-button input
    BUTTON_IP UUT1 (
        address,
        chipselect,
        clk,
        reset_n,
        write,
        read,
        button_in,
        writedata,
        readdata
    );

    // Generate a clock signal
    always begin
        #10 clk = ~clk;
    end

    initial begin
        // Initialize signals
        clk = 1'b0;
        writedata = 32'h00000000;
        address = 2'b0;
        chipselect = 1'b0;
        read = 1'b0;
        write = 1'b0;
        reset_n = 1'b0;
        button_in = 4'b1111; // Initialize buttons as unpressed (active low)

        // Apply reset
        #15 reset_n = 1'b1;

        // Test each button press and release
        #20 button_in[0] = 1'b0; // Press button 0
        #40 button_in[0] = 1'b1; // Release button 0

        #20 button_in[1] = 1'b0; // Press button 1
        #40 button_in[1] = 1'b1; // Release button 1

        #20 button_in[2] = 1'b0; // Press button 2
        #40 button_in[2] = 1'b1; // Release button 2

        #20 button_in[3] = 1'b0; // Press button 3
        #40 button_in[3] = 1'b1; // Release button 3

        // Test multiple button presses and releases in sequence
        #30 button_in[0] = 1'b0; // Press button 0
        #20 button_in[1] = 1'b0; // Press button 1 while button 0 is still pressed
        #30 button_in[0] = 1'b1; // Release button 0
        #20 button_in[1] = 1'b1; // Release button 1

        #20 button_in[2] = 1'b0; // Press button 2
        #30 button_in[3] = 1'b0; // Press button 3 while button 2 is still pressed
        #20 button_in[2] = 1'b1; // Release button 2
        #30 button_in[3] = 1'b1; // Release button 3
		  
		  #30 button_in[0] = 1'b0; // Press button 0
        #20 button_in[1] = 1'b0; // Press button 1 while button 0 is still pressed
		  #10 reset_n = 1'b0;		// reset while buttons are pressed
        #30 button_in[0] = 1'b1; // Release button 0
        #20 button_in[1] = 1'b1; // Release button 1
		  #10 reset_n = 1'b1;		// un-reset after buttons are released

    end
endmodule
