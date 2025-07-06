
module duv (
input logic clk,
input logic op_start,
input logic  [1:0] operation,
input  logic [7:0] operand_a,
input  logic [7:0] operand_b,
output logic [15:0] result
);

logic [15:0] result_temp;

always_ff @(posedge clk) 
	begin
	if( op_start == 1'b1)
		begin
		case (operation)
			  0:             result_temp = operand_a + operand_b;
			  1:             result_temp = operand_a * operand_b;
			  2:             result_temp = operand_a | operand_b;
			  3:             result_temp = operand_a & operand_b;
			endcase
		  end

		result <= result_temp;
	end

endmodule : duv