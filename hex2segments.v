module hex2segments(
	input [3:0] n,
	output reg [6:0] segments
);

always @(n) begin
	case(n)
	0:  segments=7'b1000000;  //0
	1:  segments=7'b1111001;  //1
	2:  segments=7'b0100100;  //2
	3:  segments=7'b0110000;  //3
	4:  segments=7'b0011001;  //4
	5:  segments=7'b0010010;  //5
	6:  segments=7'b0000010;  //6
	7:  segments=7'b1111000;  //7
	8:  segments=7'b0000000;  //8
	9:  segments=7'b0010000;  //9
	10: segments=7'b0001000;  //A
	11: segments=7'b0000011;  //b
	12: segments=7'b1000110;  //C
	13: segments=7'b0100001;  //d
	14: segments=7'b0000110;  //E
	
	
	15: segments=7'b1111111;  // nothing
	default: segments=7'b0111111; //-
	endcase
   end

	

endmodule