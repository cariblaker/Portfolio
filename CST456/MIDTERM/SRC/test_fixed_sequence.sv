class test_fixed_sequence extends uvm_test;
  `uvm_component_utils(test_fixed_sequence)

  function new(string name = "test_fixed_sequence", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Create the sequence and set the fixed sequence pattern
    gen_item_seq seq = gen_item_seq::type_id::create("gen_item_seq");
    seq.seq_pattern = "11011010011110000101101100";  // Set your fixed sequence
    
    // Start the sequence via the sequencer
    env.a0.sqr.start(seq);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    // This test will start when the build phase is completed
  endtask
endclass
