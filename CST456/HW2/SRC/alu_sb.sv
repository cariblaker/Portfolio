class alu_sb;
	 virtual alu_if intf;
	 
	 alu_trxn trxn_in;
	 alu_trxn trxn;
	 
	 extern function void compute_expected_value (alu_trxn trxn_in);
	 extern task check();
	 
	 function new (virtual interface alu_if alu_if_in);
		intf = alu_if_in;
	 endfunction
endclass

 
 function void alu_sb::compute_expected_value(alu_trxn trxn_in);
	 logic [7:0] a, b;
	 logic [15:0] expected_out;

	 a = trxn_in.a;
	 b = trxn_in.b;
	 $display("computing SB check: a = %h, b = %h, trxA = %h, trxB = %h", a, b, trxn_in.a, trxn_in.b);

    case (trxn_in.op) 
        0:   expected_out = a + b;
        1:   expected_out = a * b;
        2:   expected_out = a | b;
        3:   expected_out = a & b;
    endcase
	$display("expected = %0h, actual = %0h @time %0t", expected_out, trxn_in.out, $time);
	assert (expected_out == trxn_in.out)
	else begin
		$fatal (1, "op = %b, a = %h, out = %h, expected_out = %h", trxn_in.op, a, b, trxn_in.out, expected_out);
		//$display("woulda FAILED HEREEE %0t", $time);
		//$display("SCOREBOARD: op = %b, a = %h, b = %h, out = %h, expected_out = %h", trxn_in.op, a, b, trxn_in.out, expected_out);
	end
 endfunction //alu_sb
 
 task alu_sb::check();
	 trxn = new();
	 @(negedge intf.cb);
	 while (1) begin
		@(negedge intf.cb);
		trxn.op <= intf.operation;
		trxn.a <= intf.operand_a;
		trxn.b <= intf.operand_b;
		@(negedge intf.cb);
		$display("SB: Capturing result at time %0t, result = %h", $time, intf.result);

		trxn.out = intf.result;
		
		$display("Checking transaction at time: %0t", $time);
		$display("scoreboard interface check: operation = %0b, operand_a = %0h, operand_b = %0h, result = %0h, trxn.out = %0h", intf.operation, intf.operand_a, intf.operand_b, intf.result, trxn.out);
		compute_expected_value(trxn);
	end
endtask