
//gets the packet from monitor, Generated the expected result and compares with the //actual result recived from Monitor

class scoreboard;
   
  mailbox #(transaction) mon2scb;
  
  int no_transactions;
  
 function new(mailbox #(transaction) mon2scb_in);
  this.mon2scb = mon2scb_in;
 endfunction
  
  task main;
    transaction trans;
	logic [15:0] expected_out;
    forever begin
     mon2scb.get(trans);
	 case (trans.opcode)
        2'b00: expected_out = trans.a + trans.b;  
        2'b01: expected_out = trans.a * trans.b;  
        2'b10: expected_out = trans.a | trans.b;  
        2'b11: expected_out = trans.a & trans.b;  
      endcase
     if(expected_out == trans.out)
          $display("Result is as expected\n", expected_out);
     else
          $error("Wrong Result.\n\tExpected: %0d Actual: %0d", expected_out,trans.out);
      no_transactions++;
      trans.display("[ Scoreboard ]");
    end
  endtask
  
endclass