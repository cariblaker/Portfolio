
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
class environment;
  
  //generator and driver instance
  generator 	gen;
  driver    	driv;
  monitor   	mon;
  scoreboard	scb;
  
  //mailbox #(transaction) handle's
 mailbox #(transaction) gen2driv;
 mailbox #(transaction) mon2scb;
  
  //virtual interface
  virtual intf vif;
  
  //constructor
  function new(virtual intf vif_in);
    //get the interface from test
    this.vif = vif_in;
    
    //creating the mailbox #(transaction) (Same handle will be shared across generator and driver)
   gen2driv = new();
   mon2scb  = new();
    
    //creating generator and driver
    gen  = new(gen2driv);
    driv = new(vif,gen2driv);
    mon  = new(vif,mon2scb);
    scb  = new(mon2scb);
  endfunction
  
  task test();
    fork 
      gen.main();
      driv.main();
      mon.main();
      scb.main();
    join_any
  endtask
  
  task post_test();
    wait(gen.ended.triggered);
    wait(gen.repeat_count == driv.no_transactions); //Optional
    wait(gen.repeat_count == scb.no_transactions);
  endtask  
  
  //run task
  task run;
    test();
    post_test();
    $finish;
  endtask
  
endclass