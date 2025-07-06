// Contains the FAIL_UNLESS_EQUAL macro.
`include "macro.svh"
`include "interface.sv"


module tb;
    // [Step 1] Wildcard import the enumeration typedef from the typedef_pkg package.
	import typedef_pkg::*;
	
    // [Step 2] Declare clk signal and initialize with value of 1'b0.
	logic clk = 1'b0;
    logic op_start = 1'b0;
    operation_t operation;
    logic [7:0] operand_a;
	logic [7:0] operand_b;
	logic [15:0] result;
	int num_loops = 0;
    // [Step 3] Instantiate the interface and connect the clk signal.
	intf ADDERintf(.clk);

    // [Step 4] Instantiate the DUV module and connect the interface signals and the clk signal to the DUV ports.
	duv DUT(
		.clk,
		.op_start(op_start),
		.operation(operation),
		.operand_a(ADDERintf.operand_a),
		.operand_b(ADDERintf.operand_b),
		.result(ADDERintf.result)
	);
	
    // [Step 5] Always block to generate the clock.
	always begin
		#5 clk = ~clk;
	end
	
	initial begin
		operation = operation_t'(0);
		do begin
			for (int i = 0; i < 256; i++) begin
				for (int j = 0; j < 256; j++) begin
					@(negedge clk);
					operand_a = i;
					operand_b = j;
					ADDERintf.execute_op(operation, operand_a, operand_b, result);
					op_start = 1'b1;
					
					@(negedge clk);
					op_start = 1'b0;

					@(negedge clk);
					case (operation)
						0:  begin `FAIL_UNLESS_EQUAL(ADDERintf.result[8:0], (i + j) & 16'h01FF); end
						1:  begin `FAIL_UNLESS_EQUAL(ADDERintf.result, i * j); end
						2:  begin `FAIL_UNLESS_EQUAL(ADDERintf.result[7:0], i | j); end
						3:  begin `FAIL_UNLESS_EQUAL(ADDERintf.result[7:0], i & j); end
						default: begin
							$display("Unexpected operation: %0d", operation);
							end
					endcase
					$display("[Time=%0t] op_start=%b, operation=%0d, operand_a=%0d, operand_b=%0d, result=%0d", $time, op_start, operation, operand_a, operand_b, result);


				end
			end
			// Move to the next operation
			operation = operation_t'(operation + 1);
			num_loops = num_loops + 1;
			
		end while (num_loops < 4); // Continue while operation is within bounds
		#10;
		$display("Simulation finished!");
		$finish;
			
			
	end //:initial
endmodule : tb
