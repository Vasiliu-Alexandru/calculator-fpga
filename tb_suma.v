`timescale 10ns/10ps;

module tb();

reg signed [27:0] a,b;
reg valid_in,clk,rst;
wire signed [27:0] rezultat;
wire valid_out,ovrflow;

suma dut(
.n1(a),
.n2(b),
.valid_in(valid_in),
.clk(clk),
.rst(rst),
.valid_out(valid_out),
.ovrflow(ovrflow),
.d_out(rezultat)
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


repeat(10)@(posedge clk);
valid_in=1;
a=412;
b=3534;
repeat(3)@(posedge clk);
valid_in=0;

repeat(10)@(posedge clk);
valid_in=1;
a=99999900;
b=120;
repeat(3)@(posedge clk);
valid_in=0;



repeat(10)@(posedge clk);
valid_in=1;
a=-2556;
b=120;
repeat(3)@(posedge clk);
valid_in=0;


repeat(10)@(posedge clk);
valid_in=1;
a=-364526534;
b=-5346;
repeat(3)@(posedge clk);
valid_in=0;

end


always begin
#1 clk=~clk;
end

endmodule