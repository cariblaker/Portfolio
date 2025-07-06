interface alu_if(
	input logic clk,
    output logic op_start,
    output logic [1:0] operation,
    output logic [7:0] operand_a, operand_b,
    input logic [15:0] result
	);

    clocking cb @(posedge clk);
        input op_start, operation, operand_a, operand_b, result;
    endclocking

endinterface