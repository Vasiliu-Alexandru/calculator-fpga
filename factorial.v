module factorial(
    input signed [27:0] n,  //numar in C2 27b + 1 bit de semn
    input valid_in,  	    //factorialul va fi calculat la primirea semnalului de valid de la FSM
    input clk,
    input rst,
    output valid_out,
    output ovrflow,         //in caz ca factorialul depaseste 99.999.999 il setam pe 1
    output signed [27:0] d_out   //factorialul numarului, daca ovrflow e pe 1 va fi 11111111
);

    wire [27:0] factorial;
    reg [63:0] fact_temp;
    integer i;


    reg  [27:0] d_nxt,d_ff;
    reg ovr_nxt,ovr_ff;	
    reg val_nxt,val_ff;

    assign factorial = fact_temp;

    // assigns
    assign d_out=d_ff[27:0];
    assign ovrflow=ovr_ff;
    assign valid_out=val_ff;
    always @(*) begin
        //defaults
	    d_nxt=d_ff;
	    ovr_nxt=ovr_ff;
	    val_nxt=val_ff;
	
	    ovr_nxt = (n < 12 && n >= 0)? (1'b0):(1'b1);
        d_nxt= (ovr_nxt)? {28{1'b1}} : factorial[27:0];
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

    always @(n) begin
            if (n == 0) begin
                fact_temp = 1;
            end else begin
                fact_temp = 1;
                for (i = n; i > 1; i = i - 1) begin
                    fact_temp = fact_temp * i;
                end
            end
    end

  


endmodule
