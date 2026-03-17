
class transaction;
  
  rand bit [1:0] opcode;  
  rand bit [7:0] a;
  rand bit [7:0] b;
       bit [15:0] out;
  function void display(string name);
    $display("-------------------------");
    $display("- %s ",name);
    $display("-------------------------");
    $display("- a = %0d, b = %0d",a,b);
    $display("- operation = %0d",opcode);
	$display("- out = %0d",out);
    $display("-------------------------");
  endfunction
endclass