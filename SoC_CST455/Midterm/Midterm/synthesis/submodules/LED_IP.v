module LED_IP(
	 input [1:0] address,
	 input chipselect,
	 input clk,
    input reset_n,
	 input write,
	 input read,
    input [31:0] writedata,
    output [9:0] led_out,
	 output [31:0] readdata);

    reg [9:0] DATA;
    wire [31:0] read_mux_out;

    assign read_mux_out = {10 {(address == 0)}} & DATA;

    always @(posedge clk or negedge reset_n)
    begin
        if (reset_n == 0)
            DATA <= 0;
        else if (chipselect && write && (address == 0))
            DATA <= writedata[9:0];
    end

    assign readdata = {32'b0 | read_mux_out};
    assign led_out = DATA;

endmodule
