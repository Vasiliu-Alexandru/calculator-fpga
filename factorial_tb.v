`timescale 1ns/1ps

module factorial_tb();

    reg signed [27:0] n;
    reg valid_in;
    reg clk;
    reg rst;

    wire valid_out;
    wire ovrflow;
    wire signed [27:0] d_out;

    factorial uut (
        .n(n),
        .valid_in(valid_in),
        .clk(clk),
        .rst(rst),
        .valid_out(valid_out),
        .ovrflow(ovrflow),
        .d_out(d_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        valid_in = 0;
        n = 0;

        rst = 0;
        #10;
        rst = 1;
        #10;

        n = 5;
        valid_in = 1;
        #10;
        valid_in = 0;

        wait (valid_out);
        #10;

        n = 15;
        valid_in = 1;
        #10;
        valid_in = 0;

        wait (valid_out);
        #10;

        n = -1;
        valid_in = 1;
        #10;
        valid_in = 0;

        wait (valid_out);
        #10;

        n = 6;
        valid_in = 1;
        #10;
        valid_in = 0;

        wait (valid_out);
        #10;

    end

endmodule
