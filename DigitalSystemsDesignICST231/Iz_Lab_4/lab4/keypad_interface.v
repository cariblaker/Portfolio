module keypad_interface (
	input clk,
	input [3:0] cols,
   output reg [3:0] key,
	output reg key_pressed,
	output reg [3:0] rows

);

reg [1:0] count;


always @ (posedge clk) 
	begin
		case (count)
			2'b00: 
				begin
					rows <= 4'b0111; // set row 1 to '0'
				end
			2'b01: 
				begin
					rows <= 4'b1011; // set row 2 to '0'
				end
			2'b10: 
				begin
					rows <= 4'b1101; // set row 3 to '0'
				end
			2'b11: 
				begin
					rows <= 4'b1110; // set row 4 to '0'
				end
			default: 
				begin
					rows <= 4'b1111; // all rows set to '1'
				end
    endcase
		count <= count + 1;
  end
  
  
always @(posedge clk)
	begin
		if(rows == 4'b0111)
			begin
				case (cols)
					4'b0111 : 
						begin
							key <= 4'b0001; 
							key_pressed <= 1'b1;
						end
					4'b1011 :
						begin
							key <= 4'b0010;
							key_pressed <= 1'b1;
						end
					4'b1101 :
						begin
							key <= 4'b0011;
							key_pressed <= 1'b1;
						end
					4'b1110 :
						begin
							key <= 4'b1010;
							key_pressed <= 1'b1;
						end
					default :
						begin
							key <= key;
							key_pressed <= 1'b0;
						end
				endcase

			end 
		else if(rows == 4'b1011)
			begin
				case (cols)
					4'b0111 : 
						begin
							key <= 4'b0100;
							key_pressed <= 1'b1;
						end
					4'b1011 :
						begin
							key <= 4'b0101;
							key_pressed <= 1'b1;
						end
					4'b1101 :
						begin
							key <= 4'b0110;
							key_pressed <= 1'b1;
						end
					4'b1110 :
						begin
							key <= 4'b1011;
							key_pressed <= 1'b1;
						end
					default :
						begin
							key <= key;
							key_pressed <= 1'b0;
						end
				endcase

			end 
		else if(rows == 4'b1101)
			begin
				case (cols)
					4'b0111 : 
						begin
							key <= 4'b0111;
							key_pressed <= 1'b1;
						end
					4'b1011 :
						begin
							key <= 4'b1000;
							key_pressed <= 1'b1;
						end
					4'b1101 :
						begin
							key <= 4'b1001;
							key_pressed <= 1'b1;
						end
					4'b1110 :
						begin
							key <= 4'b1100;
							key_pressed <= 1'b1;
						end
					default :
						begin
							key <= key;
							key_pressed <= 1'b0;
						end
				endcase

			end 
		else if(rows == 4'b1110)
			begin
				case (cols)
					4'b0111 : 
						begin
							key <= 4'b1110; //*
							key_pressed <= 1'b1;
						end
					4'b1011 :
						begin
							key <= 4'b0000;	//0
							key_pressed <= 1'b1;
						end
					4'b1101 :
						begin
							key <= 4'b1111; //#
							key_pressed <= 1'b1;
						end
					4'b1110 :
						begin
							key <= 4'b1101; //D
							key_pressed <= 1'b1;
						end
					default :
						begin
							key <= key;
							key_pressed <= 1'b0;
						end
				endcase

			end 
			else
				begin
					key <= key;
					key_pressed <= 1'b0;
				end	
	end
  

endmodule 