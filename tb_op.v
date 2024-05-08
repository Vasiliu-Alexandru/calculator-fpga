`timescale 1ns/1ps;

module tb_op();

reg signed [27:0] a,b;
reg valid_in,clk,rst;
wire signed [27:0] rezultat_suma, rezultat_produs, rezultat_diferenta, rezultat_impartire;
wire valid_out_s, valid_out_d, valid_out_p, valid_out_i, err_suma, err_diferenta, err_produs, err_impartire;

suma s(
.n1(a),
.n2(b),
.valid_in(valid_in),
.clk(clk),
.rst(rst),
.valid_out(valid_out_s),
.ovrflow(err_suma),
.d_out(rezultat_suma)
);
diferenta d(
.n1(a),
.n2(b),
.valid_in(valid_in),
.clk(clk),
.rst(rst),
.valid_out(valid_out_d),
.ovrflow(err_diferenta),
.d_out(rezultat_diferenta)
);
produs p(
.n1(a),
.n2(b),
.valid_in(valid_in),
.clk(clk),
.rst(rst),
.valid_out(valid_out_p),
.ovrflow(err_produs),
.d_out(rezultat_produs)
);
impartire i(
.n1(a),
.n2(b),
.valid_in(valid_in),
.clk(clk),
.rst(rst),
.valid_out(valid_out_i),
.err(err_impartire),
.d_out(rezultat_impartire)
);


initial begin
a=0;
b=0;
valid_in=0;
clk=0;
rst=1;



repeat(2)@(posedge clk);
rst=0; //entering reset
repeat(5)@(posedge clk);
rst=1; //out of reset


repeat(50)@(posedge clk);
valid_in=1;
a=412;
b=3534;
repeat(1)@(posedge clk);
valid_in=0;

repeat(50)@(posedge clk);
valid_in=1;
a=99999900;
b=120;
repeat(1)@(posedge clk);
valid_in=0;



repeat(50)@(posedge clk);
valid_in=1;
a=-2556;
b=0;
repeat(1)@(posedge clk);
valid_in=0;


repeat(50)@(posedge clk);
valid_in=1;
a=-364526534;
b=-5346;
repeat(1)@(posedge clk);
valid_in=0;

repeat(50)@(posedge clk);
valid_in=1;
a=169;
b=13;
repeat(1)@(posedge clk);
valid_in=0;

repeat(50)@(posedge clk);
valid_in=1;
a=168;
b=13;
repeat(1)@(posedge clk);
valid_in=0;

end


always begin
#1 clk=~clk;
end

endmodule
