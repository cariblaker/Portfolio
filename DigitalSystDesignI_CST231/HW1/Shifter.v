module Shifter(
	input [7:0]data_in,
	input [2:0]sh_amt,
	input [1:0]opcode,
	output reg [7:0]data_out
);

reg [7:0]data_temp;

always @(*)
	begin
	
	if (sh_amt > 0)
		begin
			case (opcode)
		
				0 : 
					begin
						case(sh_amt)
							1 :	data_temp <= { data_in[6:0], data_in[7] };
							2 :	data_temp <= { data_in[5:0], data_in[7:6] }; 
							3 :	data_temp <= { data_in[4:0], data_in[7:5] };
							4 :	data_temp <= { data_in[3:0], data_in[7:4] };
							5 :	data_temp <= { data_in[2:0], data_in[7:3] };
							6 : 	data_temp <= { data_in[1:0], data_in[7:2] };
							7 :	data_temp <= { data_in[0], data_in[7:1] };
						endcase
					end
				1 : data_temp <= data_in << sh_amt;
				2 : 
					begin
						case(sh_amt)
							1 :	data_temp <= { data_in[0], data_in[7:1] };
							2 :	data_temp <= { data_in[1:0], data_in[7:2] };
							3 :	data_temp <= { data_in[2:0], data_in[7:3] };
							4 :	data_temp <= { data_in[3:0], data_in[7:4] };
							5 :	data_temp <= { data_in[4:0], data_in[7:5] };
							6 : 	data_temp <= { data_in[5:0], data_in[7:6] };
							7 :	data_temp <= { data_in[6:0], data_in[7] };
						endcase
					end
				3 : data_temp <= data_in >> sh_amt;
				
			endcase
		end
	
	else
		data_temp <= data_in;
	
	end


always @(data_temp)
begin
	
	data_out <= data_temp;

end



endmodule
