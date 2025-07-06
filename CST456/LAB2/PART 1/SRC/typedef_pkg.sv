package typedef_pkg;

    typedef enum logic [1:0]
    {
        ADD = 2'b00,
        MULT = 2'b01,
        OR = 2'b10,
        AND = 2'b11
    } operation_t;

    typedef logic [7:0] operand_t;
    typedef logic [15:0] result_t;

endpackage : typedef_pkg