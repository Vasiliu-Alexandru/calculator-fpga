module factorial(
    input signed [27:0] n,        // 27-bit signed number with sign bit
    input valid_in,               // Start calculation signal from FSM
    input clk,                    // Clock signal
    input rst,                    // Reset signal
    output reg valid_out,         // Output valid signal
    output reg ovrflow,           // Overflow flag
    output reg signed [27:0] d_out // Factorial result, if overflow occurs set to all 1s
);

    reg [63:0] fact_temp;         // Temporary register to hold factorial value
    reg [27:0] i;                 // Loop variable
    reg [1:0] state;              // State variable

    localparam IDLE = 2'b00,      // Idle state
               CALC = 2'b01,      // Calculation state
               DONE = 2'b10;      // Done state

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            d_out <= 0;
            ovrflow <= 0;
            valid_out <= 0;
            fact_temp <= 1;
            i <= 0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (valid_in) begin
                        if (n < 0 || n >= 12) begin
                            // Set overflow flag if input is negative or too large
                            ovrflow <= 1;
                            d_out <= {28{1'b1}};
                            valid_out <= 1;
                            state <= DONE;
                        end else begin
                            // Start factorial calculation
                            ovrflow <= 0;
                            fact_temp <= 1;
                            i <= n;
                            state <= CALC;
                        end
                    end
                end
                CALC: begin
                    if (i > 1) begin
                        fact_temp <= fact_temp * i;
                        i <= i - 1;
                    end else begin
                        d_out <= fact_temp[27:0];
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
