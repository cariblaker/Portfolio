

module clk_dv
	#(parameter CLK_DIV = 12500) (
	input clk,
	input rst,
	output reg new_clk
);
 
//-----------------------------------------------------------
// Signal Declarations: reg
//-----------------------------------------------------------
reg [25:0] count;


always @(posedge clk or posedge rst)			//handles count
	begin
	
		if (rst)
			begin
				count <= 0;
			end
			
		else
			begin

				if (count < CLK_DIV - 1)
					count <= count + 1;
						
				else
					count <= 0;
			
			end
			
	end
	
	
	always @(posedge clk or posedge rst)		//handles output
	begin
		if (rst)
			begin
				new_clk <= 0;
			end
		
		else
			begin
			
				if (count == CLK_DIV - 1)
					new_clk <= ~new_clk;						
						
				else
					new_clk <= new_clk;
			
			end
	
	end

	
endmodule
