class Item extends uvm_sequence_item;
  `uvm_object_utils(Item)
  rand bit  inp;
  bit 		outp;
  
  virtual function string convert2str();
    return $sformatf("in=%0d, out=%0d", inp, outp);
  endfunction
  
  function new(string name = "Item");
    super.new(name);
  endfunction
  
  constraint c1 { inp dist {0:/20, 1:/80}; }
endclass