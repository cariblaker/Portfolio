module HW2b(input [1:0]a, input ena, output reg[3:0]y);
	
	always @ (a, ena)
		begin
			if(ena == 0)
				begin
					if(a[0]==1'bX & a[1]==1'bX) y=4'b1111;
					else if(a[0]==1'b0 & a[1]==1'b0) y=4'b1110;
					else if(a[0]==1'b0 & a[1]==1'b1) y=4'b1101;
					else if(a[0]==1'b1 & a[1]==1'b0) y=4'b1011;
					else if(a[0]==1 & a[1]==1) y=4'b0111;
				end
			else
				y=1'bZ;
		end
		
endmodule