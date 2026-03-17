class alu_trxn;

	/*typedef enum logic [1:0]
		{
		ADD = 2'b00,
		MULT = 2'b01,
		OR = 2'b10,
		AND = 2'b11
		} OPTYPE;*/
		
	rand logic [7:0] a, b;
	logic [15:0] out;
	rand logic [1:0] op;

	//rand OPTYPE op;

	task print_trxn (string name);
		$info("TRXN-- %s: op=%0b op_a = %h, op_b = %h", name, op, a, b);
	endtask //print_trxn

endclass //alu_trxn