module putere(
    input signed [27:0] n1,       //numar in C2 27b + 1 bit de semn
    input signed [27:0] n2,       
    input valid_in,               
    input clk,                    
    input rst,                    
    output reg valid_out,         
    output reg ovrflow,           // Overflow flag
    output reg signed [27:0] d_out // rezultat, daca avem OVRFLOW, e 28 biti de 1
);

    reg [63:0] pow_temp;       
    reg [27:0] i;                 
    reg [1:0] state;           

    localparam IDLE = 2'b00,      //
               CALC = 2'b01,      //    starile FSM-ului 
               DONE = 2'b10;      //
    localparam signed [27:0] MAX_VAL = 99999999;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            d_out <= 0;
            ovrflow <= 0;
            valid_out <= 0;
            pow_temp <= 1;
            i <= 0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    valid_out <= 0; 
                    if (valid_in) begin
                        if (n2 < 0) begin
                            ovrflow <= 1;
                            d_out <= {28{1'b1}};
                            valid_out <= 1;
                            state <= DONE;
                        end else begin
                            ovrflow <= 0;
                            pow_temp <= 1;
                            i <= 0;
                            state <= CALC;
                        end
                    end
                end
                CALC: begin
                    if (i < n2) begin
                        pow_temp <= pow_temp * n1;
                        i <= i + 1;
                        if (pow_temp > MAX_VAL) begin
                            ovrflow <= 1;
                            d_out <= {28{1'b1}};
                            state <= DONE;
                        end
                    end else begin
                        d_out <= pow_temp[27:0];
                        state <= DONE;
                    end
                end
                DONE: begin
                    valid_out <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end 
endmodule
