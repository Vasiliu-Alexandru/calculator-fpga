module bin2bcd(
    input [27:0] bin, // signed integer
    input valid_in, 
    input clk,
    input rst,
    output valid_out,
    output [31:0] bcd, // 8 4-bit digits
    output sign // 1 if the number is negative
);

    reg [27:0] abs_bin;
    integer i, j;

    reg  [31:0] bcd_nxt, bcd_ff, bcd_temp;
    reg val_nxt,val_ff, val_temp, sign_nxt, sign_ff, sign_temp;

    assign bcd = bcd_ff[31:0];
    assign valid_out = val_ff;
    assign sign = sign_ff;


    always @(posedge clk or negedge rst) begin // flip-flop
        if(!rst) begin
            bcd_ff <= 32'b0;
	        val_ff <= 1'b0;
            sign_ff <= 1'b0;
        end else begin
	        bcd_ff <= bcd_nxt;
	        val_ff <= val_nxt;
            sign_ff <= sign_nxt;
        end
    end

    always @(*) begin // double-dabble algorithm
        if (bin[27] == 1'b1) begin
            sign_temp = 1'b1;
            abs_bin = ~bin + 1;
        end else begin
            sign_temp = 1'b0;
            abs_bin = bin;
        end
        
        bcd_temp = 32'b0;

        for (i = 0; i < 28; i = i + 1) begin
            
            bcd_temp = bcd_temp << 1;
            bcd_temp[0] = abs_bin[27];
            abs_bin = abs_bin << 1;
            
            if(i != 27) begin
                for (j = 0; j < 8; j = j + 1) begin
                    if (bcd_temp[(4*j)+:4] >= 5) begin
                        bcd_temp[(4*j)+:4] = bcd_temp[(4*j)+:4] + 3;
                    end
                end
            end
        end

        bcd_nxt = bcd_temp;
        sign_nxt = sign_temp;
        val_nxt = valid_in;
    end

endmodule