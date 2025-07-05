module elegant_bcd_sum(
	input [3:0]num1,
	input [3:0]num2,
	output reg [3:0]sum,
	output reg carry
);

	reg [4:0] temp_sum;
	
	always @ (num1, num2)
		begin
		
			temp_sum = num1 + num2;
		
			if (temp_sum < 10)
				begin
				
					sum = temp_sum;
					carry = 0;
				
				end
				
			else
				begin
				
					temp_sum = temp_sum + 6;
					carry = 1;
					sum = temp_sum[3:0];
				
				end
		
		end
		
endmodule
