module sumator_20b(
 input [19:0] n1,
 input [19:0] n2,
 input c_in,
 output c_out,
 output [19:0] s
);

wire [18:0] carry;


sumator_1b b0(
.a(n1[0]),
.b(n2[0]),
.c_in(c_in),
.c_out(carry[0]),
.s(s[0])
);

sumator_1b b1(
.a(n1[1]),
.b(n2[1]),
.c_in(carry[0]),
.c_out(carry[1]),
.s(s[1])
);

sumator_1b b2(
.a(n1[2]),
.b(n2[2]),
.c_in(carry[1]),
.c_out(carry[2]),
.s(s[2])
);

sumator_1b b3(
.a(n1[3]),
.b(n2[3]),
.c_in(carry[2]),
.c_out(carry[3]),
.s(s[3])
);

sumator_1b b4(
.a(n1[4]),
.b(n2[4]),
.c_in(carry[3]),
.c_out(carry[4]),
.s(s[4])
);

sumator_1b b5(
.a(n1[5]),
.b(n2[5]),
.c_in(carry[4]),
.c_out(carry[5]),
.s(s[5])
);


sumator_1b b6(
.a(n1[6]),
.b(n2[6]),
.c_in(carry[5]),
.c_out(carry[6]),
.s(s[6])
);

sumator_1b b7(
.a(n1[7]),
.b(n2[7]),
.c_in(carry[6]),
.c_out(carry[7]),
.s(s[7])
);

sumator_1b b8(
.a(n1[8]),
.b(n2[8]),
.c_in(carry[7]),
.c_out(carry[8]),
.s(s[8])
);

sumator_1b b9(
.a(n1[9]),
.b(n2[9]),
.c_in(carry[8]),
.c_out(carry[9]),
.s(s[9])
);

sumator_1b b10(
.a(n1[10]),
.b(n2[10]),
.c_in(carry[9]),
.c_out(carry[10]),
.s(s[10])
);

sumator_1b b11(
.a(n1[11]),
.b(n2[11]),
.c_in(carry[10]),
.c_out(carry[11]),
.s(s[11])
);

sumator_1b b12(
.a(n1[12]),
.b(n2[12]),
.c_in(carry[11]),
.c_out(carry[12]),
.s(s[12])
);

sumator_1b b13(
.a(n1[13]),
.b(n2[13]),
.c_in(carry[12]),
.c_out(carry[13]),
.s(s[13])
);

sumator_1b b14(
.a(n1[14]),
.b(n2[14]),
.c_in(carry[13]),
.c_out(carry[14]),
.s(s[14])
);

sumator_1b b15(
.a(n1[15]),
.b(n2[15]),
.c_in(carry[14]),
.c_out(carry[15]),
.s(s[15])
);

sumator_1b b16(
.a(n1[16]),
.b(n2[16]),
.c_in(carry[15]),
.c_out(carry[16]),
.s(s[16])
);

 
sumator_1b b17(
.a(n1[17]),
.b(n2[17]),
.c_in(carry[16]),
.c_out(carry[17]),
.s(s[17])
);

sumator_1b b18(
.a(n1[18]),
.b(n2[18]),
.c_in(carry[17]),
.c_out(carry[18]),
.s(s[18])
);

sumator_1b b19(
.a(n1[19]),
.b(n2[19]),
.c_in(carry[18]),
.c_out(c_out),
.s(s[19])
);





endmodule