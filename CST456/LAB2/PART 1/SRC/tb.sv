// Contains the FAIL_UNLESS_EQUAL macro.
`include "macro.svh"
	
module tb; 
// [Step 1] Wildcard import the typedef_pkg package.
	import typedef_pkg::*;
	
// [Step 2] Declare signals. The operation, operand_a, operand_b, and result signals must use the
    // data types from the typedef_pkg package. Initialize the clk signal with a value of 1'b0.
	logic clk = 1'b0;
    logic op_start;
    operation_t operation;
    operand_t operand_a;
    operand_t operand_b;
	operation_t op;
    result_t result;
	int num_loops = 0;
// [Step 3] Instantiate the DUV module. The module is declared as
	
duv dut (
	.clk(clk),
	.op_start(op_start),
	.operation(operation),
	.operand_a(operand_a),
	.operand_b(operand_b),
	.result(result));

// [Step 4] Always block to generate the clock.
	
always begin
	#5 clk = ~clk;
end

	
// [Step 5] Test the DUV using an initial block. Be sure to initialize all DUV input variables, and use the
    // $finish system task to halt simulation at the end of the test.
	
initial begin
    op_start = 0;
    operation = ADD;
    op = ADD; // Declare and initialize operation type
	operand_a = 0;
	operand_b = 0;
    do begin
        for (int i = 0; i < 256; i++) begin
            for (int j = 0; j < 256; j++) begin
				@(negedge clk);
                operation = op;
                operand_a = i;
                operand_b = j;
				op_start = 1'b1;
				#10;
                
                @(negedge clk);
                op_start = 1'b0;

                @(negedge clk);
                case (op)
                    0:  begin `FAIL_UNLESS_EQUAL(result[8:0], (i + j) & 16'h01FF); end
                    1:  begin `FAIL_UNLESS_EQUAL(result, i * j); end
                    2:  begin `FAIL_UNLESS_EQUAL(result[7:0], i | j); end
                    3:  begin `FAIL_UNLESS_EQUAL(result[7:0], i & j); end
					default: begin
						$display("Unexpected operation: %0d", op);
						end
                endcase
				$display("[Time=%0t] op_start=%b, operation=%0d, operand_a=%0d, operand_b=%0d, result=%0d", $time, op_start, operation, operand_a, operand_b, result);


            end
        end
        // Move to the next operation
        op = operation_t'(op + 1);
		num_loops = num_loops + 1;
        
    end while (num_loops < 4); // Continue while operation is within bounds
	#10;
	$display("Simulation finished!");
	$finish;
end

	
endmodule : tb