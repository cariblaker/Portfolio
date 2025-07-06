//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------
interface intf(input logic clk);

  logic op_start;
  logic [7:0] a;
  logic [7:0] b;
  logic [1:0] opcode;
  logic [15:0] out;
  
endinterface
