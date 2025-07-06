// Contains the FAIL_UNLESS_EQUAL and RND_CHECK macros.
`include "macro.svh"

module tb;

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
		logic [15:0] actual_result;
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
	
	covergroup ALU_Coverage;
        coverpoint operation { // Ensure all operations are tested
            bins add_bin = {2'b00};   // ADD
            bins mul_bin = {2'b01};   // MULT
            bins or_bin  = {2'b10};   // OR
            bins and_bin = {2'b11};   // AND
        }
        coverpoint operand_a { // Cover different operand values
            bins min_val = {8'h00};    // 0
            bins max_val = {8'hFF};    // 255
            bins mid_val = {8'h80};    // 128
        }
        coverpoint operand_b { // Same as operand_a
            bins min_val = {8'h00};   
            bins max_val = {8'hFF};    
            bins mid_val = {8'h80};    
        }
        cross operation, operand_a, operand_b; // Ensure full coverage of input combinations
    endgroup

    ALU_Coverage cov = new(); // Instantiate the coverage group

		// [Step 6] Test the DUV using an initial block. Be sure to initialize all DUV input variables,
		// and use the $finish system task to halt simulation at the end of the test.
	initial begin
		// Initialize signals
		op_start = 0;

		repeat (10) begin  // Run 10 randomized tests
			// Generate random values
			`RND_CHECK(std::randomize(operation, operand_a, operand_b)); // Check if randomization was successful
			op_start = 1; // Assert start signal
			@(negedge clk);
			op_start = 0; // De-assert after 1 cycle
			@(negedge clk);
			// Compute expected result based on operation
			case (operation)
				2'b00: scoreboard.expected_result = operand_a + operand_b;   // ADD (lower 9 bits)
				2'b01: scoreboard.expected_result = operand_a * operand_b;   // MULT (full 16 bits)
				2'b10: scoreboard.expected_result = operand_a | operand_b;   // OR (lower 8 bits)
				2'b11: scoreboard.expected_result = operand_a & operand_b;   // AND (lower 8 bits)
			endcase

			@(negedge clk);

			// Store ALU result in scoreboard
			scoreboard.operation = operation;
			scoreboard.operand_a = operand_a;
			scoreboard.operand_b = operand_b;
			scoreboard.actual_result = result;

			// Call checker task
			check();
			cov.sample();
		end
	$display("Functional Coverage: %f%%", cov.get_coverage());
	// Finish simulation
	$finish;
	end

	// [Step 5] Implement the check task to check the scoreboard.
	task check;
		`FAIL_UNLESS_EQUAL(scoreboard.expected_result, scoreboard.actual_result)
	endtask

endmodule : tb