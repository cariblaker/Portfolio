module Question5(
    input clk,
    input updn,
    input emg,
    output reg [3:0] floor
);



reg [3:0]state;
reg [3:0]next;



parameter zero = 4'b0000, one = 4'b0001, two = 4'b0010, three = 4'b0011, four = 4'b0100, five = 4'b0101, six = 4'b0110, seven = 4'b0111, eight = 4'b1000, nine = 4'b1001, ten = 4'b1010, eleven = 4'b1011, twelve = 4'b1100, fourteen = 4'b1110, fifteen = 4'b1111;



initial
begin

	floor = zero;
	state = zero;

end


always @(posedge clk or posedge emg)
begin
	
	state <= next;

end


always @(state or emg or updn)
begin

	if (emg)
	begin
	
		case (state)
			zero : next = state;
			one : next = zero;
			two : next = one;
			three : next = two;
			four : next = three;
			five : next = four;
			six : next = five;
			seven : next = six;
			eight : next = seven;
			nine : next = eight;
			ten : next = nine;
			eleven : next = ten;
			twelve : next = eleven;
			fourteen: next = twelve;
			fifteen : next = fourteen;
		endcase	
	end
	
	
	else
	begin
		if (updn)		//goooo up
		begin
	
			case (state)
				zero : next = one;
				one : next = two;
				two : next = three;
				three : next = four;
				four : next = five;
				five : next = six;
				six : next = seven;
				seven : next = eight;
				eight : next = nine;
				nine : next = ten;
				ten : next = eleven;
				eleven : next = twelve;
				twelve : next = fourteen;
				fourteen: next = fifteen;
				fifteen : next = state;
			endcase	

		end 	//end if updn
	
	
		else		//gooooooin down
		begin
		
			case (state)
				zero : next = state;
				one : next = zero;
				two : next = one;
				three : next = two;
				four : next = three;
				five : next = four;
				six : next = five;
				seven : next = six;
				eight : next = seven;
				nine : next = eight;
				ten : next = nine;
				eleven : next = ten;
				twelve : next = eleven;
				fourteen: next = twelve;
				fifteen : next = fourteen;
			endcase	
			
	
		end 		//end down else
		
	end
	
	floor = state;			//seems to work better with output assigned here
	

end


endmodule

