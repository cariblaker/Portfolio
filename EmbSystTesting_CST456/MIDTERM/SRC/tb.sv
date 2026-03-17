`include "uvm_macros.svh"
import uvm_pkg::*;

`include "interface.sv"
`include "item.sv"
`include "gen_item_seq.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "driver.sv"
`include "agent.sv"
`include "env.sv"
`include "base_test.sv"



`define LENGTH 4

module tb;
	reg clk;
	logic reset, inp, outp;
  
  always #10 clk =~ clk;
  des_if _if(clk, reset, inp, outp);
	
	duv u0 	( .clk(clk),
			 .reset(reset),
			 .inp(inp),
			 .outp(outp)
			 );
  
	initial begin
		clk <= 0;
		
		uvm_config_db#(virtual des_if)::set(null, "", "des_vif", _if);
		run_test("test_1011");
	end
 endmodule