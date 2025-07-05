module code (
	input clk,
	input key_pressed,
	input [3:0]key,
	output reg [15:0]seg_out,
	output reg [15:0]code_out,
	output reg start 
);

	localparam idle = 2'b00;
	localparam go 	 = 2'b01;
	localparam stop = 2'b11;
	localparam in 	 = 2'b10;

	reg [5:0]count;
	reg [1:0]state;
	reg [11:0]count_sec;

	
	initial 
		begin
			count <= 0;
			state <= idle;
			count_sec <= 0;
		end

		
	always @(posedge clk)
	begin
		case (state)
			idle:
				begin
					if (key_pressed)
						begin
							state <= go;
						end
					else
						begin
							seg_out <= 16'h0000;
							code_out <= code_out;
							start <= 1'b0;
						end
				end
			
			in:
				begin
					if (key_pressed)
						begin
							state <= go;
						end						  	     
					else if (count_sec == 3750)						//3750 clock cycles @ 250hz = 15 seconds til timeout
						begin
							state <= idle;
							count_sec <= 0;
						end
						
					else 
						begin
							count_sec <= count_sec + 1;
						end
				end
			
			go:
				begin
					if (key == 4'b1111)							//# hit, time to check
						begin
							code_out = seg_out;
							start <= 1'b1;
							state <= idle;
						end
						
					else if (key == 4'b1110)					//* hit,  reset
						begin
							state <= idle;
						end
					else
						begin
							seg_out = {seg_out[12:0], key};
							state <= stop;
						end
					
				end
				
			stop:
				begin
					if (count < 6'b111111)
						begin
							count <= count + 1;
						end
					else 
						begin
							state <= in;
							count <= 6'b000000;
						end
				end
				
			default:
				begin
					state <= idle;
				end
			endcase
	end






endmodule 
