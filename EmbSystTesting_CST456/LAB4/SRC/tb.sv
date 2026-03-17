// Contains the FAIL_UNLESS_EQUAL and RND_CHECK macros.
`include "macro.svh"
`include "typedef_pkg.sv"

module tb;
import typedef_pkg::*;

// [Step 1] Declare signals that connect to DUV. Intialize the clk signal with a value of 1'b0.
	logic clk = 1'b0;
	logic op_start;
	logic [1:0] operation;
	logic [7:0] operand_a;
	logic [7:0] operand_b;
	logic [15:0] result;

// [Step 2] Declare the scoreboard that holds the operation, operand_a, operand_b, and results values.
	typedef struct {
		logic [1:0] operation;
		logic [7:0] operand_a;
		logic [7:0] operand_b;
		logic [15:0] expected_result;
	} scoreboard_t;

	scoreboard_t scoreboard;


// [Step 3] Instantiate the DUV module.	
	duv ALU (
		.clk(clk),
		.op_start(op_start),
		.operation(operation),
		.operand_a(operand_a),
		.operand_b(operand_b),
		.result(result)
	);


// [Step 4] Always block to generate the clock.
	always begin
		#5 clk = ~clk;
	end

		
// [Step 5] Test the DUV using an initial block. Be sure to initialize all DUV input variables,
// and use the $finish system task to halt simulation at the end of the test.
	initial begin
		// Initialize inputs
		op_start = 0;
		operation = 0;
		operand_a = 0;
		operand_b = 0;
		
		#10;

		repeat (10) begin 		// 10 test cases
			stimulus(); 		// new test case
			@(negedge clk);
			op_start = 1;
			@(negedge clk);
			op_start = 0;
			monitor(); 			// capture expected result
			@(negedge clk);
			check(); 			// validate result, 2 clk cycles after op_start assertion
		end
		
		$finish;
	end


// [Step 6] Implement the stimUlus task
	task stimulus();
		begin
			`RND_CHECK(std::randomize(operation, operand_a, operand_b));
		end
	endtask


// [Step 7] Implement the monitor task
	task monitor();
		begin
			scoreboard.operation = operation;
			scoreboard.operand_a = operand_a;
			scoreboard.operand_b = operand_b;
			case (operation)
				2'b00: scoreboard.expected_result = operand_a + operand_b; // ADD
				2'b01: scoreboard.expected_result = operand_a * operand_b; // MULT
				2'b10: scoreboard.expected_result = operand_a | operand_b; // OR
				2'b11: scoreboard.expected_result = operand_a & operand_b; // AND
			endcase
		end
	endtask

	
// [Step 8] Implement the check task to check the scoreboard.
	task check();
		begin
			`FAIL_UNLESS_EQUAL(result, scoreboard.expected_result);
		end
	endtask


endmodule : tb