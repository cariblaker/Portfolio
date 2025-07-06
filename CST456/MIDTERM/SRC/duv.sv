module duv (
    input logic clk,             
    input logic reset,             
    input logic inp,              
    output logic outp             
);

    typedef enum logic [2:0] {
        S0 = 3'b000,            
        S1 = 3'b001,             // 1
        S2 = 3'b011,             // 11
        S3 = 3'b110,             // 110
        S4 = 3'b010,             // 10 
        S5 = 3'b101              // 101
    } state_t;

    state_t current_state, next_state;

    // state transition with asynchronous reset
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // logic for next state and output
    always_comb begin

		next_state = current_state;
		outp = 1'b0;

		case (current_state)
			S0: begin				//init
				outp = 1'b0;
				if (inp)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin				// 1 sensed
				outp = 1'b0;
				if (inp)
					next_state = S2;
				else
					next_state = S4;
			end
			S2: begin				//11 sensed
				outp = 1'b0;
				if (inp)
					next_state = S2;
				else
					next_state = S3;
			end
			S3: begin				//110 sensed
				if (inp) begin
					next_state = S5;
					outp = 1'b0;
				end
				else begin
					next_state = S0;
					outp = 1'b1;		// Output 1 for "1100"
				end
			end
			S4: begin				//10 sensed
				outp = 1'b0;
				if (inp)
					next_state = S5;
				else
					next_state = S0;
			end
			S5: begin				//101 sensed
				if (inp) begin
					next_state = S2;
					outp = 1'b1;	// Output 1 for "1011"
				end
				else begin
					next_state = S4;
					outp = 1'b0;
				end
			end
		endcase
	end

endmodule : duv


