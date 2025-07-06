// driver, monitor and sequencer          
class agent extends uvm_agent;
  `uvm_component_utils(agent)
  
  virtual des_if vif;
  
  function new(string name="agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  driver 		d0; 		// Driver handle
  monitor 		m0; 		// Monitor handle
  uvm_sequencer #(Item)	s0; 		// Sequencer Handle

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    s0 = uvm_sequencer#(Item)::type_id::create("s0", this);
    d0 = driver::type_id::create("d0", this);
    m0 = monitor::type_id::create("m0", this);
	
    if (!uvm_config_db#(virtual des_if)::get(this, "", "des_vif", vif)) begin
      `uvm_fatal("AGENT", "Virtual interface not set in configuration database")
    end
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    d0.seq_item_port.connect(s0.seq_item_export);
	d0.vif = vif;
    m0.vif = vif;
  endfunction

endclass