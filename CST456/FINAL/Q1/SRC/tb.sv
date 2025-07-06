
`include "interface.sv"

//-------------------------[NOTE]---------------------------------
//Particular testcase can be run by uncommenting, and commenting the rest
`include "random_test.sv"
//`include "directed_test.sv"
//----------------------------------------------------------------

module tb;
  bit clk;
  
  //clock generation
  always #5 clk = ~clk;		//i guess we're not doing a clocking block in the interface...
  
  intf i_intf(clk);

  test t1(i_intf);
  
  //DUT instance, interface signals are connected to the DUT ports
  duv DUT (
    .clk(i_intf.clk),
    .op_start(i_intf.op_start),
    .A(i_intf.a),
    .B(i_intf.b),
    .opcode(i_intf.opcode),
    .OUT(i_intf.out)
   );
  
  
endmodule