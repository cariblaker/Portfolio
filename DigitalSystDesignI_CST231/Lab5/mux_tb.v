

module mux_tb();

//-----------------------------------------------------------
// Signal Declarations: reg
//-----------------------------------------------------------
	reg clk, reset, ready, button_0, button_1;
	reg [7:0]data_sw;
	
	wire [7:0]data_out;
	wire enable;
	
	mux U1(clk, reset, ready, button_0, button_1, data_sw, enable);

initial
	begin
	
		clk <= 1'b0;
		data_sw <= 8'b01000010;
		
	end
	
	
always
	begin
		#10 clk <= ~clk;
	end



endmodule
