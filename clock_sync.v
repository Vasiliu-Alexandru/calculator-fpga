module clock_sync(
    input clk,
    input signal,
    output posedge_detected
);

reg signal_d1, signal_d2, signal_d3;

assign posedge_detected = (signal_d2 & ~signal_d3);

always @(posedge clk) begin
    signal_d1 <= signal;
    signal_d2 <= signal_d1;
    signal_d3 <= signal_d2;
end

endmodule