module suma(
 input signed [27:0] n1,  //numar in C2 27b + 1 bit de semn
 input signed [27:0] n2,  //numar in C2 27b + 1 bit de semn
 input valid_in,   //suma va fi calculata la primirea semnalului de valid de la FSM
 input clk,
 input rst,
 output valid_out,
 output ovrflow,   //in caz ca suma depaseste 99.999.999 il setam pe 1
 output signed [27:0] d_out   //suma celor doua numere, daca ovrflow e pe 1 va fi 1111111111111111111111111111
);

wire signed [28:0] s;


reg  [27:0] d_nxt,d_ff;
reg ovr_nxt,ovr_ff;	
reg val_nxt,val_ff;


// assigns
assign d_out=d_ff[27:0];
assign ovrflow=ovr_ff;
assign valid_out=val_ff;

always @(*) begin
    //defaults
	d_nxt=d_ff;
	ovr_nxt=ovr_ff;
	val_nxt=val_ff;
	
	d_nxt= (s<=99_999_999 && s>=-99_999_999)?s[27:0]:  {28{1'b1}};
	ovr_nxt = (s<=99_999_999 && s>=-99_999_999)? (1'b0):(1'b1);
	val_nxt=valid_in;
end


always @(posedge clk or negedge rst) begin


  if(!rst) begin
    d_ff<=0;
	ovr_ff<=0;
	val_ff<=0;
  
  end else begin
	d_ff<=d_nxt;
	ovr_ff<=ovr_nxt;
	val_ff<=val_nxt;
  
  end

end


assign s=n1+n2;



endmodule
