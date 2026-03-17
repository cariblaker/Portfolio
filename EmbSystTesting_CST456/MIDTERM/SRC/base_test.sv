class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  
  function new(string name = "base_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  env  				e0;
  bit[3:0]  pattern_1;
  bit[3:0]  pattern_2;
  gen_item_seq 		seq;
  virtual des_if	vif;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Create the environment
    e0 = env::type_id::create("e0", this);
    
    // Get virtual IF handle from top level and pass it to everything
    // in env level
	 if (!uvm_config_db#(virtual des_if)::get(this, "", "des_vif", vif))
		`uvm_fatal("TEST", "Did not get vif")
		
	uvm_config_db#(virtual des_if)::set(this, "e0.a0.*", "_if", vif);
    
    // Setup pattern queue and place into config db
    uvm_config_db#(bit[3:0])::set(this, "*", "ref_pattern_1", pattern_1);
	uvm_config_db#(bit[3:0])::set(this, "*", "ref_pattern_2", pattern_2);
    
    // Create sequence and randomize it
    seq = gen_item_seq::type_id::create("seq");
    seq.randomize();
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    apply_reset();
	$display("about to start sequence!");
	//wait(vif.reset == 0);
	seq.start(e0.a0.s0);
    #200;
    phase.drop_objection(this);
  endtask
  
  virtual task apply_reset();
    vif.reset <= 1;
    vif.inp <= 0;
    repeat(2) @ (posedge vif.clk);
    vif.reset <= 0;
    repeat(3) @ (posedge vif.clk);
  endtask
endclass
    
class test_1011 extends base_test;
  `uvm_component_utils(test_1011)
  
  function new(string name="test_1011", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    pattern_1 = 4'b1011;
	pattern_2 = 4'b1100;
    super.build_phase(phase);
    seq.randomize() with { num inside {[300:500]}; };
  endfunction
endclass
