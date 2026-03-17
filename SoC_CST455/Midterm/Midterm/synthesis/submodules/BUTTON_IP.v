module BUTTON_IP(
    input [1:0] address,
    input chipselect,
    input clk,
    input reset_n,
    input write,
    input read,
    input [3:0] button_in,  // 4-bit input for four buttons
    input [31:0] writedata,
    output reg [31:0] readdata
);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            readdata <= 32'b0;
        end
        else begin
            // If a read operation is requested, output the current state of button_in
            if (chipselect && read) begin
                readdata <= {28'b0, button_in};  // Only the lower 4 bits represent button states
            end
        end
    end
endmodule

