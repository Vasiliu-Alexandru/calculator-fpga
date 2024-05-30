
module bin_2_bcd(
	input [15:0] d_in,
	output wire [3:0] thousands,
	output wire [3:0] hundreds,
	output wire [3:0] tens,
	output wire [3:0] units
	);
	

	reg [15:0] bcd;
	assign units=bcd[3:0];
	assign tens=bcd[7:4];
	assign hundreds=bcd[11:8];
	assign thousands=bcd[15:12];
	
integer i;
	
always @(*) begin
    bcd=0;		 	
    for (i=0;i<14;i=i+1) begin					//Iterate once for each bit in input number
        if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;		//If any BCD digit is >= 5, add three
	if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
	if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
	if (bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] + 3;
	bcd = {bcd[14:0],d_in[13-i]};				//Shift one bit, and shift in proper bit from input 
    end
end
	
endmodule