//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------
//gets the packet from generator and drive the transaction paket items into interface (interface is connected to DUT, so the items driven into interface signal will get driven in to DUT) 

class driver;
  
  //used to count the number of transactions
  int no_transactions;
  
  //creating virtual interface handle
  virtual intf vif;
  
  //creating mailbox #(transaction) handles
  mailbox #(transaction) gen2driv;
  
  //constructor
  function new(virtual intf vif_in, mailbox #(transaction) gen2driv_in);
    //getting the interface
    this.vif = vif_in;
    //getting the mailbox #(transaction) handles from  environment 
   this.gen2driv = gen2driv_in;
  endfunction
  
  //duv has no reset sooo..........
 /* //Reset task, Reset the Interface signals to default/initial values
  task reset;
    wait(vif.reset);
    $display("[ DRIVER ] ----- Reset Started -----");
    vif.a <= 0;
    vif.b <= 0;
    vif.valid <= 0;
    wait(!vif.reset);
    $display("[ DRIVER ] ----- Reset Ended   -----");
  endtask*/
  
  //drives the transaction items to interface signals
  task main;
    forever begin
     transaction trans;
     gen2driv.get(trans);
      @(posedge vif.clk);
      vif.op_start <= 1;
	  vif.opcode <= trans.opcode;
      vif.a     <= trans.a;
      vif.b     <= trans.b;
      @(posedge vif.clk);
      vif.op_start <= 0;
      trans.out   = vif.out;
      @(posedge vif.clk);
      trans.display("[ Driver ]");
      no_transactions++;
    end
  endtask
  
endclass