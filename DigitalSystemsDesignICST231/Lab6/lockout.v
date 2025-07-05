module lockout(
    input clk,
    input L,
    output reg P
);

    // Name the States
    parameter [1:0] stateA = 2'b00,
                    stateB = 2'b01,
                    stateC = 2'b11;

    // Create memory for the state machine
    reg [1:0] cur_state;

    // Always block to handle State Machine
 always @(posedge clk)
 begin
		case(cur_state)
			 stateA :
				  if(!L)
						cur_state <= stateB;
				  else
						cur_state <= cur_state;
			 stateB :
				  if(!L)
						cur_state <= stateC;
				  else
						cur_state <= stateA;
			 stateC :
				  if(!L)
						cur_state <= cur_state;
				  else
						cur_state <= stateA;
			 default : cur_state <= stateA;
		endcase

 end


    // Always block to handle Combinational Outputs
    always @(cur_state)
    begin

        case(cur_state)
            stateA  : P <= 1;
            stateB  : P <= 0;
            stateC  : P <= 1;
            default : P <= 1;
        endcase

    end



endmodule 