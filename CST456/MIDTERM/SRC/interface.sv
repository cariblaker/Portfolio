// using a virtual interface handle
interface des_if (input logic clk,
	output logic reset,
	output logic inp,
	input logic outp
);

    // Clocking block to capture inputs and outputs on the rising edge of clk
    clocking cb @(posedge clk);
        input inp, outp, reset;
    endclocking
endinterface
    
// Top level test