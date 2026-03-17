module tb_duv;

    logic clk;
    logic rst;
    logic in;
    logic out;

    // Instantiate the design under test (DUT)
    duv dut (
        .clk(clk),
        .rst(rst),
        .in(in),
        .out(out)
    );

    // Clock generation (50 MHz)
    always #10 clk = ~clk;

    // Stimulus process
    initial begin
        $display("Time\tState\tReset\tInput\tOutput");
        $monitor($time, "\t%b\t%b\t%b\t%b", dut.current_state, rst, in, out);

        // Initialize signals
        clk = 0;
        rst = 1;
        in = 0;
        #25; // Allow time for reset propagation

        // Release reset
        rst = 0;

        // input sequence 11110000101101100
        in = 1; #20;
        in = 1; #20;
        in = 1; #20;
        in = 1; #20;
        in = 0; #20;
        in = 0; #20;
        in = 0; #20;
        in = 1; #20;
        in = 0; #20;
        in = 1; #20;
        in = 1; #20;
        in = 0; #20;
        in = 1; #20;
        in = 1; #20;
        in = 0; #20;
        in = 0; #20;
        //start same sequence  over, to test the reset
        in = 1; #20;
        in = 1; #20;
        in = 1; #20;
        in = 1; #20;
        in = 0; #20;
        in = 0; #15;
        // test reset at asynchronous moment
        rst = 1; 
        in = 0; #5;
        in = 1; #20;
        in = 0; #20;
        in = 1; #20;
        in = 1; #20;
        in = 0; #20;
        in = 1; #20;
        in = 1; #20;
        in = 0; #20;
        in = 0; #20;

        // End simulation
        #50;
        $finish;
    end

endmodule

