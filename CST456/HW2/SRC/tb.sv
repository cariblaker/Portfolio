`include "alu_if.sv"
`include "alu_trxn.sv"
`include "alu_bfm.sv"
`include "alu_sb.sv"


module tb();
	logic clk;
	logic op_start;
	logic [7:0] operand_a, operand_b;
	logic [1:0] operation;
	logic [15:0] result;

	alu_if intf (clk, op_start, operation, operand_a, operand_b, result);
	
	duv alu(
		.clk(clk),
		.op_start(op_start),
		.operation(operation),
		.operand_a(operand_a),
		.operand_b(operand_b),
		.result(result)
	);

	initial begin
		clk = 1'b0;
		forever begin
			#10 clk = ~clk;
		end
	end


	initial begin
		automatic int num_trxn = 10;
		automatic alu_bfm bfm = new(intf);
		automatic alu_sb sb = new(intf);

		fork
			bfm.drive();
			sb.check();
		join

		for (int i = 0; i < num_trxn; i++) begin
			@(negedge intf.clk);
		end
		$finish;
	end
endmodule : tb
