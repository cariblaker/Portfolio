`ifndef MACRO_SVH
    `define MACRO_SVH

    `define FAIL_UNLESS_EQUAL(a,b,c="") \
    if ((a) !== (b)) begin \
        $display ("FAIL_UNLESS_EQUAL[%s]: Expected %h but actual value is %h.", c, a, b); \
    end

    `define RND_CHECK(a) \
    if (!a) begin \
        $display ("Randomization failure. Simulation halted."); \
        $finish; \
    end
`endif
