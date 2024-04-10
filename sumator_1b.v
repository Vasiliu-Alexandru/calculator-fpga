module sumator_1b (
 input a,
 input b,
 input c_in,
 output c_out,
 output s
);

assign s=a^b^c_in;
assign c_out=a&b | b&c_in | a&c_in;

endmodule