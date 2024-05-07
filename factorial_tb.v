`timescale 10ns/10ps;

module factorial_tb();

    reg signed [27:0] nr;
    reg valid_in,clk,rst;
    wire signed [27:0] rezultat;
    wire valid_out,ovrflow;

    factorial dut(
        .n(nr),
        .valid_in(valid_in),
        .clk(clk),
        .rst(rst),
        .valid_out(valid_out),
        .ovrflow(ovrflow),
        .d_out(rezultat)
    );

    initial begin
        nr=0;
        valid_in=0;
        clk=0;
        rst=1;

        repeat(2)@(posedge clk);
        rst=0; //entering reset
        repeat(5)@(posedge clk);
        rst=1; //out of reset

        repeat(10)@(posedge clk);
        valid_in=1;
        nr=5;
        repeat(3)@(posedge clk);
        valid_in=0;
        
        repeat(10)@(posedge clk);
        valid_in=1;
        nr=8;
        repeat(3)@(posedge clk);
        valid_in=0;
        
        repeat(10)@(posedge clk);
        valid_in=1;
        nr=0;
        repeat(3)@(posedge clk);
        valid_in=0;
        
        repeat(10)@(posedge clk);
        valid_in=1;
        nr=-2;
        repeat(3)@(posedge clk);
        valid_in=0;
        
        repeat(10)@(posedge clk);
        valid_in=1;
        nr=4;
        repeat(3)@(posedge clk);
        valid_in=0;
        
        repeat(10)@(posedge clk);
        valid_in=1;
        nr=45;
        repeat(3)@(posedge clk);
        valid_in=0;
        
    end


    always begin
        #1 clk=~clk;
    end

endmodule