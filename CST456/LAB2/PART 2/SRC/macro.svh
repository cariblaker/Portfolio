`ifndef MACRO_SVH
    `define MACRO_SVH

    `define FAIL_UNLESS_EQUAL(a,b,c="") \
    if ((a) !== (b)) \
    begin \
        $display ("FAIL_UNLESS_EQUAL[%s]: Expected %h but actual value is %h.", c, a, b); \
		$finish; \
    end
`endif
