// Contains the FAIL_UNLESS_EQUAL macro.
`include "macro.svh"

module tb;

    typedef enum logic [1:0] {
        ADD = 2'b00,            
        MULT = 2'b01,
        OR = 2'b10,
        AND = 2'b11
    } op;

	logic clk;
    logic op_start;
    logic [1:0] operation;
    logic [7:0] operand_a;
	logic [7:0] operand_b;
	logic [15:0] result;
	
	duv ALU0 (.clk(clk), .op_start(op_start), .operation(operation), .operand_a(operand_a), .operand_b(operand_b), .result(result));	
	
// [Step 3] Always block to generate the clock.
	always #1ns clk = ~clk;
	
initial begin	
	clk = 1'b0;
	for (int op_val = 0; op_val < 4; op_val++) begin : operation_loop
		for (int valA = 0; valA < 256; valA++) begin : operand_A_loop
			for (int valB = 0; valB < 256; valB++) begin : operand_B_loop
				@(negedge clk);
				op_start = 1'b1;
				operation = op_val;
				operand_a = valA;
				operand_b = valB;
				
				@(negedge clk);
				op_start = 1'b0;
				
				@(negedge clk);
				case (valA)
					0: `FAIL_UNLESS_EQUAL(valA + valB, result[8:0])
					1: `FAIL_UNLESS_EQUAL(valA * valB, result)
					2: `FAIL_UNLESS_EQUAL(valA | valB, result[7:0])
					3: `FAIL_UNLESS_EQUAL(valA & valB, result[7:0])
				endcase
			end : operand_B_loop
		end : operand_A_loop
	end : operation_loop
	
	$display("Finished Successfully!");
	$finish;
	
end // Initial end

endmodule : tb