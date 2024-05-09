module diferenta(
 input signed [27:0] n1,  //numar in C2 27b + 1 bit de semn
 input signed [27:0] n2,  //numar in C2 27b + 1 bit de semn
 input valid_in,   //diferenta va fi calculata la primirea semnalului de valid de la FSM
 input clk,
 input rst,
 output valid_out,
 output ovrflow,   //in caz ca diferenta  depaseste 99.999.999 il setam pe 1
 output signed [27:0] d_out   //diferenta celor doua numere, daca ovrflow e pe 1 va fi 1111111111111111111111111111
);

suma instanta_suma (
 .n1(n1),
 .n2(~n2+1'b1),
 .valid_in(valid_in),
 .clk(clk),
 .rst(rst),
 .valid_out(valid_out),
 .ovrflow(ovrflow),
 .d_out(d_out)
);

endmodule
