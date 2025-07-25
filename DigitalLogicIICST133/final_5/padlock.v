module padlock(
	input reset,
	input clk,
	input [3:0]code,
	output reg unlock,
	output reg err
);


reg [2:0] state, next;

parameter init = 3'b000, a = 3'b001, b = 3'b010, c = 3'b011, unlocked = 3'b100, error = 3'b111;


initial
begin

	state = init;
	unlock = 1'b0;
	err = 1'b0;

end


always @(state, code)
begin

	case(state)
	
		init : begin
			if (code == 4'b0010)
				next = a;
			else
				next = error;
			end
			
		a : begin
			if (code == 4'b0100)
				next = b;
			else
				next = error;
			end
			
		b : begin
			if (code == 4'b1000)
				next = c;
			else
				next = error;
			end
			
		c : begin
			if (code == 4'b0001)
				next = unlocked;
			else
				next = error;
			end
			
		error : begin
			if (reset)
				next = a;
			else
				next = error;
		end
			
	endcase

end


always @(posedge clk, posedge reset)
begin
	
	if (reset)
		state <= init;
	else
		state <= next;

end


always @(state)
begin
	case(state)
		init : begin
		unlock = 0;
		err = 0;
		end
		a : begin
		unlock = 0;
		err = 0;
		end
		b : begin
		unlock = 0;
		err = 0;
		end
		c : begin
		unlock = 0;
		err = 0;
		end
		unlocked : begin
		unlock = 1;
		err  = 0;
		end
		error : begin
		unlock = 0;
		err = 1;
		end
		default : begin
		unlock = 0;
		err = 0;
		end
	endcase
	
end



endmodule
