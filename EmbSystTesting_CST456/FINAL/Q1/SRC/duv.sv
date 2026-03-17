module duv ( 
	input logic clk, 
	input logic op_start, 
	input  logic [7:0] A, 
	input  logic [7:0] B, 
	input logic  [1:0] opcode, 
	output logic [15:0] OUT 
); 
logic [15:0] result_temp; 

	always_ff @(posedge clk)  
	begin 
		
		if( op_start == 1'b1) 
		begin 
			case (opcode) 
				0:             result_temp = A + B; 
				1:             result_temp = A * B; 
				2:             result_temp = A | B; 
				3:             result_temp = A & B; 
			endcase 
		end 
			
		OUT <= result_temp;
		
			
	end 
	
endmodule
