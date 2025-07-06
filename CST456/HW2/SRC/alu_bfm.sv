class alu_bfm;

	virtual interface alu_if intf;
	alu_trxn trxn;
	
	extern task drive();
	extern task drive_trxn (alu_trxn trxn);
	
	function new (virtual interface alu_if alu_if_in);
		intf = alu_if_in;
	endfunction
	
endclass //alu_bfm

task alu_bfm::drive();
	while (1) begin
		@intf.cb;
		//$display("Driving transaction at time: %0t", $time);
		trxn = new();
		trxn.randomize();
		trxn.print_trxn("bfm");
		drive_trxn(trxn);
	end
endtask //drive

task alu_bfm::drive_trxn (alu_trxn trxn);
	@intf.cb;
	intf.operation <= trxn.op;
	intf.operand_a <= trxn.a;
	intf.operand_b <= trxn.b;
	intf.op_start <= 1;
	@intf.cb;
	
	intf.op_start <= 0;
	//$display("intf.operation = %0b, trxn.op = %0b, intf.a = %h, trxn.a = %h, intf.b = %h, trxn.b = %h,", intf.operation, trxn.op, intf.operand_a, trxn.a, intf.operand_b, trxn.b);
	
	@intf.cb;
	$display("BFM: Capturing result at time %0t, result = %h", $time, intf.result);
	trxn.out = intf.result;
	//$display("intf.result = %h, trxn.out = %h", intf.result, trxn.out);
endtask //drive_trxn