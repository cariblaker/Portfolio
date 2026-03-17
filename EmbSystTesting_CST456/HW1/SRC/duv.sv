module duv (
    input logic clk,             
    input logic rst,             
    input logic in,              
    output logic out             
);

    typedef enum logic [2:0] {
        S0 = 3'b000,            
        S1 = 3'b001,             // 1
        S2 = 3'b010,             // 11
        S3 = 3'b011,             // 110
        S4 = 3'b100,             // 1100 (output 1)
        S5 = 3'b101,             // 10
        S6 = 3'b110,             // 101
        S7 = 3'b111              // 1011 (output 1)
    } state_t;

    state_t current_state, next_state;
	 
	 initial begin
		current_state <= S0;
	 end

    // state transition with asynchronous reset
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // logic for next state and output
    always_comb begin
        next_state = current_state;
        out = 1'b0;

        case (current_state)
            S0: begin
					 out = 1'b0;
                if (in)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
					 out = 1'b0;
                if (in)
                    next_state = S2;
                else
                    next_state = S0;
            end
            S2: begin
					 out = 1'b0;
                if (in)
                    next_state = S2;
                else
                    next_state = S3;
            end
            S3: begin
                if (in) begin
                    next_state = S1;
						  out = 1'b0;
					 end
                else begin
                    next_state = S4;
                    out = 1'b1; // "1100"
                end
            end
            S4: begin
					 out = 1'b0;
                if (in)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S5: begin
					 out = 1'b0;
                if (in)
                    next_state = S6;
                else
                    next_state = S0;
            end
            S6: begin
                if (in) begin
                    next_state = S7;
                    out = 1'b1; // Output 1 for "1011"
					 end
                else begin 
                    next_state = S5;
						  out = 1'b0;
					 end
            end
            S7: begin
					 out = 1'b0;
                if (in)
                    next_state = S2;
                else
                    next_state = S5;
            end
        endcase
    end

endmodule : duv


