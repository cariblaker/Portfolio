class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  function new(string name="scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  

  bit[3:0] 	ref_pattern_1;	//1011
  bit[3:0] 	ref_pattern_2;	//1100
  bit[3:0] 	act_pattern = 0;
  bit 		exp_out = 0;
    // Buffer to hold previous output for comparison
  bit       prev_out = 0;
  bit[3:0]	prev_pattern = 0;
  
  uvm_analysis_imp #(Item, scoreboard) m_analysis_imp;
    
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    m_analysis_imp = new("m_analysis_imp", this);
    if (!uvm_config_db#(bit[3:0])::get(this, "env.sb0", "ref_pattern_1", ref_pattern_1)) begin
      `uvm_fatal("SCBD", "Did not get ref_pattern_1!")
    end
	if (!uvm_config_db#(bit[3:0])::get(this, "*", "ref_pattern_2", ref_pattern_2)) begin
      `uvm_fatal("SCBD", "Did not get ref_pattern_2!")
    end
  endfunction
  
  virtual function void write(Item item); 
	prev_pattern = act_pattern;
    act_pattern = {act_pattern[2:0], item.inp};

	if (!(ref_pattern_1 ^ act_pattern) | !(ref_pattern_2 ^ act_pattern)) begin
		`uvm_info("SCBD", $sformatf("Pattern found: %0b, next out should be 1", act_pattern), UVM_LOW)
		 exp_out = 1;
	end else begin
		`uvm_info("SCBD", $sformatf("No match: %0b, next out should be 0", act_pattern), UVM_LOW)
		exp_out = 0;
	end
	
	if (item.outp != exp_out) begin
      `uvm_error("SCBD", $sformatf("ERROR ! out=%0d exp=%0d", item.outp, exp_out))
    end else begin
      `uvm_info("SCBD", $sformatf("PASS ! out=%0d exp=%0d", item.outp, exp_out), UVM_LOW)
    end

		
  endfunction
endclass
