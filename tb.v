`timescale 10ns/10ps;

module tb();

reg [19:0] a,b;

wire z;
wire [19:0] rezultat;
wire [20:0] rezultat_f;
assign rezultat_f={z,rezultat};
sumator_20b dut(
.n1(a),
.n2(b),
.c_in(1'b0),
.c_out(z),
.s(rezultat)
);

initial begin
a=0;
b=0;

end

always begin
#1 {a,b}={a,b}*2;
end

endmodule