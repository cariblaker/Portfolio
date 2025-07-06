// [Step 1] Create an enumeration typedef for the four operations: ADD, MULT, OR, and AND.
// Name the typedef operation_t.
package typedef_pkg;

    typedef enum logic [1:0]
    {
        ADD = 2'b00,
        MULT = 2'b01,
        OR = 2'b10,
        AND = 2'b11
    } operation_t;

endpackage : typedef_pkg