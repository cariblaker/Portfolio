module ALU(
	input wire [3:0]a,
	input wire [3:0]b,
	input wire [2:0]select,
	output reg [5:0]fout
);

reg [3:0]a_temp;

always @(select)
	begin
		
		case(select)
			0 : fout = a > b;
			1 : fout = b > a;
			2 : 
			begin
				a_temp[0] = a[3];
				a_temp[1] = a[0];
				a_temp[2] = a[1];
				a_temp[3] = a[2];
				fout = a_temp;
			end
			3 :
			begin
				a_temp[0] = a[1];
				a_temp[1] = a[2];
				a_temp[2] = a[3];
				a_temp[3] = a[0];
				fout = a_temp;
			end
			4 : fout = a + b;
			5 : 
			begin
			fout = a - b;
			if (fout < 0)
				fout = ~fout + 1;
			
			end
			6 : fout = b << 1;
			7 : fout = b >> 1;
		endcase

	end


endmodule