

module ALU(
	input clk,
	input reset,
	input [3:0]Data,
	input [2:0]Opcode,
	input GO,
	output reg cout,
	output reg borrow,
	output reg [3:0]Result,
	output reg led_idle, led_wait, led_rdy, led_done
);

	reg [2:0]state;
	reg [3:0]A, B;											
	reg [2:0]code;
	
	
	localparam idle	= 3'b000;
	localparam stateA = 3'b001;
	localparam wait_s = 3'b010;
	localparam stateB = 3'b011;
	localparam done 	= 3'b100;
	localparam ready	= 3'b101;
	
	
	initial
	begin
		state <= idle;
		cout <= 0;
		borrow <= 0;
	end
		
		
	always @(posedge clk)									//next state logic
		begin
		
			if (reset)											//always back to idle if reset
				state <= idle;
			
			else
				begin
		
					case (state)
					
						idle 	  :
							begin
								if (GO)							//go kicks off state machine
									state <= stateA;
								else
									state <= state;
							end
						
						stateA  :
							begin									//immediately transition to wait state
								state <= wait_s;
							end
					
						wait_s  :
							begin
								if (GO)
									state <= state;
								else
									state <= stateB;				//wait for GO signal to drop
							end
						stateB  :
							begin
								state <= done;
							end
							
						done 	  :
							begin
								state <= ready;			//after done, immediately transition to ready
							end
							
						ready	  :
							begin
								state <= idle;				//after ready, immediately transition back to idle
							end
						
						default :
							begin
								state <= idle;
							end
							
					endcase
					
				end
					
		end

		

	always @(state)								//output logic
		begin
		
			case (state)
				
				idle :
					begin
						{led_idle, led_wait, led_rdy, led_done} <= 4'b1000;
					end
					
				stateA :
					begin
						{led_idle, led_wait, led_rdy, led_done, cout, borrow} <= 6'b000000;
						B <= Data;
						code <= Opcode;
					end
					
				wait_s :
					begin
						{led_idle, led_wait, led_rdy, led_done, cout, borrow} <= 6'b010000;
					end
				
				stateB :
					begin
						{led_idle, led_wait, led_rdy, led_done, cout, borrow} <= 6'b000000;
						A <= Data;
					end
					
				done :
					begin
						
						case (code)
							3'b000 : 
								begin
									Result <= A + B;
									cout <= (A[3] & B[3]) | (A[3] & Result[3]) | (B[3] & Result[3]);
									borrow <= 0;
								end
							3'b001 :
								begin
									Result <= A - B;
									cout <= 0;
									borrow <= ((B > A) ? 1 : 0);
								end
							3'b010 :
								begin
									Result <= ~A;
									cout <= 0;
									borrow <= 0;
								end
							3'b011 :
								begin
									Result <= ~B;
									cout <= 0;
									borrow <= 0;
								end
							3'b100 :
								begin
									Result <= A & B;
									cout <= 0;
									borrow <= 0;
								end
							3'b101 :
								begin
									Result <= A | B;
									cout <= 0;
									borrow <= 0;
								end
							3'b110 :
								begin
									Result <= A ^ B;
									cout <= 0;
									borrow <= 0;
								end
							3'b111 :
								begin
									Result <= A ~^ B;
									cout <= 0;
									borrow <= 0;
								end
							default :
								begin
									Result <= Result;
									cout <= 0;
									borrow <= 0;
								end
						endcase	
							
						{led_idle, led_wait, led_rdy, led_done} <= 4'b0001;
						
					end
		
				ready :
					begin
						{led_idle, led_wait, led_rdy, led_done} <= 4'b0010;
					end
		
			endcase
			
		end
		
		
		
endmodule


	