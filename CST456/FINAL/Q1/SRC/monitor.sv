
//Samples the interface signals, captures into transaction packet and send the packet to scoreboard.

class monitor;
  
  //creating virtual interface handle
  virtual intf vif;
  
  //creating mailbox #(transaction) handle
  mailbox #(transaction) mon2scb;
  
  //constructor
  function new(virtual intf vif_in, mailbox #(transaction) mon2scb_in);
    //getting the interface
    this.vif = vif_in;
    //getting the mailbox #(transaction) handles from  environment 
   this.mon2scb = mon2scb_in;
  endfunction
  
  //sample interface signal and send the sample packet to scoreboard
  task main;
    forever begin
      transaction trans;
      trans = new();
	  
      @(posedge vif.clk);
      wait(vif.op_start);
	  trans.opcode = vif.opcode;
      trans.a   = vif.a;
      trans.b   = vif.b;
	  
      @(posedge vif.clk);
      trans.out   = vif.out;
	  mon2scb.put(trans);
	  
      @(posedge vif.clk);
      trans.display("[ Monitor ]");
	  
    end
  endtask
  
endclass