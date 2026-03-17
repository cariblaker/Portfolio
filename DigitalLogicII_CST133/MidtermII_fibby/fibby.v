module fibby(
	input clk,
	input rst,
	input ena,
	output reg [4:0]fib
);

reg [3:0]count_1;		//needs space for 0-8;

reg [4:0]count_2;		//needs space for 0-21;



	initial			//starts counts at 0 and 1
		begin
			count_1 <= 4'b0000;
			count_2 <= 5'b00001;
		end		
		

	always @(posedge clk or posedge rst)
		begin
		
			if (rst)
				fib <= 5'b00000;
			
			else				//encompassing else
				begin 
				
					if (ena)
					begin
						if (fib < 5'b10101)	//if enabled and not to the end of the sequence, continue the sequence
						begin
								fib <= count_1 + count_2;
								count_1 <= count_2;
								count_2 <= fib;
						end
							
						else				//if we ARE at the end of the sequence, start over!
								count_1 <= 4'b0000;
								count_2 <= 5'b00001;
								fib <= count_1 + count_2;
							
					end
						
		
				end 			//end encompassing else
		
		end







endmodule 