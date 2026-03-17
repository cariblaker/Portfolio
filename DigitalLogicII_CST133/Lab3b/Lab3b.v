module Lab3b(input [3:0]a, input ena, output r0, output r1, output valid);

encoder E1(a, ena, r0, r1, valid);


endmodule