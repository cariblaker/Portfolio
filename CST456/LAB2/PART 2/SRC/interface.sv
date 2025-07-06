

interface intf (input logic clk);
    // [Step 1] Wildcard import the enumeration typedef from the typedef_pkg package.
	import typedef_pkg::*;


    // [Step 2] Declare the signals, other than clk, that will connect to the DUV.

	logic  [1:0] operation;
	logic [7:0] operand_a;
	logic [7:0] operand_b;
	logic [15:0] result;

    // [Step 3] Implement the execute_op task.
	task execute_op(
		input operation_t op, 
		input logic [7:0] op_a,
		input logic [7:0] op_b,
		output logic [15:0] res
	);
		@(negedge clk);
			operation = op;
			operand_a = op_a;
			operand_b = op_b;
		@(negedge clk);
			res = result;
			
	endtask: execute_op


endinterface : intf