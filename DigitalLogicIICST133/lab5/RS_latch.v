 module RS_latch(
 input R,
 input S,
 output Q, 
 output Q_not
 );

 
 nor U2(Q_not, R, Q);
 nor U1(Q, S, Q_not);


 
 
 endmodule
 