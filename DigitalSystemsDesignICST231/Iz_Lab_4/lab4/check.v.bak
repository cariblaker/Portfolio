module check (
	input clk,
	input reset,
	input [15:0]code,
	input go,
	output error,
	output open,
	output unlocking
);

parameter idle;
parameter check; 
parameter green;
parameter red;


reg [1:0]state;
reg [15:0] valid_codes;

assign valid_codes = 4'h1234

always @(posedge clk)
	begin
		if(reset)
			begin 
				state <= idle;
			end
		else 
			begin
				case(state)
					idle:
						begin
							if(go)
								begin
									state <= check;
								end
							else
								begin
									state <= state;
								end
						end
						
					check: 
						begin 
							if(code == valid_codes)
								begin
									state <= green;
								end
							else
								begin
									state <= red;
								end
								
						end
						
					green:
						begin
							state <= idle;
						end
						
					red:
						begin
							state <= idle;
						end
					
					default:
						state <= idle;
				endcase
			end
	end
	
	
always @(posedge clk)
	begin 
		case (state)
			idle:
				begin
					error = 0;
					open = 0;
					unlocking = 0;
				end
			check: 
				begin
					error = 0;
					open = 0;
					unlocking = 1;
				end			
			green:
				begin
					error = 0;
					open = 1;
					unlocking = 0;
				end			
			red:
				begin
					error = 1;
					open = 0;
					unlocking = 0;
				end	
			default:
				begin
					error = 0;
					open = 0;
					unlocking = 0;
				end	
			endcase
	end


endmodule 