
module impartire(

 input signed [27:0] n1,  //numar in C2 27b + 1 bit de semn
 input signed [27:0] n2,  //numar in C2 27b + 1 bit de semn
 input valid_in,  
 input clk,
 input rst,
 output valid_out,
 output err,   
 output signed  [27:0] d_out  

);


reg [1:0]state_nxt, state_ff;
reg start_nxt,start_ff;
reg valid_out_nxt,valid_out_ff;
wire ok;
wire start;
reg        sign_a_ff,sign_a_nxt,sign_b_ff,sign_b_nxt;
reg [27:0] dat_a_ff,dat_a_nxt,dat_b_ff,dat_b_nxt,d_out_ff,d_out_nxt;
wire [31:0] result_t;

assign start=start_ff;
assign valid_out=valid_out_ff;
assign d_out=d_out_ff;
wire rst_in_beetw;
assign rst_in_beetw = (state_ff==2'd3);




      div_structural div_structural_i (  
           .clk(clk),   
           .start(start),  
           .reset(~rst | rst_in_beetw),  
           .A({4'd0,dat_a_ff}),   
           .B({4'd0,dat_b_ff}),   
           .D(result_t),   
           .R(),   
           .ok(ok),  
           .err(err)  
      );  




always @(*) begin
	
	state_nxt=state_ff;
	start_nxt=start_ff;
	sign_a_nxt=sign_a_ff;
	sign_b_nxt=sign_b_ff;
	dat_a_nxt=dat_a_ff;
	dat_b_nxt=dat_b_ff;
	valid_out_nxt=1'b0;

	d_out_nxt=d_out_ff;
	

	case(state_ff)
	0: begin
	  if(valid_in) begin
		start_nxt=1'b1;
		state_nxt=2'd1;
		dat_a_nxt = n1[27]? ~n1+1 : n1;
		dat_b_nxt=n2[27]? ~n2+1 : n2;
		sign_a_nxt=n1[27];
		sign_b_nxt=n2[27];
	  end
	end
	
	1: begin

		state_nxt=2'd2;  //wait for ok to go  away after start
	end
	

	
	
	2: begin
		if(ok) begin
			start_nxt=0;
			state_nxt=2'd3;
			valid_out_nxt=1'b1;
			if(sign_a_ff!=sign_b_ff) begin
			
			d_out_nxt=~result_t[27:0]+1;
			end
			
			else begin
			
			d_out_nxt=result_t[27:0];
			end
			
		end
	end
	3:begin
		state_nxt=2'd0;
		

	
	end
	endcase

end



always @(posedge clk, negedge rst) begin
	if(!rst) begin
		state_ff<=0;
		start_ff<=0;
	    sign_a_ff<=0;
	    sign_b_ff<=0;
		valid_out_ff<=0;
		dat_a_ff<=0;
		dat_b_ff<=0;
	    d_out_ff<=0;

	end else begin
		state_ff<=state_nxt;
		start_ff<=start_nxt;
		sign_a_ff<=sign_a_nxt;
		sign_b_ff<=sign_b_nxt;
		valid_out_ff<=valid_out_nxt;
		dat_a_ff<=dat_a_nxt;
		dat_b_ff<=dat_b_nxt;
		d_out_ff=d_out_nxt;

	end

end

endmodule
 module div_structural(  
   input      clk,  
   input      reset,  
   input      start,  
   input [31:0]  A,  
   input [31:0]  B,  
   output [31:0]  D,  
   output [31:0]  R,  
   output     ok ,   // =1 when ready to get the result   
   output err  
   );  
   reg          active;   // True if the divider is running  
   reg [4:0]    cycle;   // Number of cycles to go  
   reg [31:0]   result;   // Begin with A, end with D  
   reg [31:0]   denom;   // B  
   reg [31:0]   work;    // Running R  
   // Calculate the current digit  
   wire [32:0]   sub = { work[30:0], result[31] } - denom;  
       assign err = !B;  
   // Send the results to our master  
   assign D = result;  
   assign R = work;  
   assign ok = ~active;
   // The state machine  
   always @(posedge clk,posedge reset) begin  
     if (reset) begin  
       active <= 0;  
       cycle <= 0;  
       result <= 0;  
       denom <= 0;  
       work <= 0;  
     end  
     else if(start) begin  
       if (active) begin  
         // Run an iteration of the divide.  
         if (sub[32] == 0) begin  
           work <= sub[31:0];  
           result <= {result[30:0], 1'b1};  
         end  
         else begin  
           work <= {work[30:0], result[31]};  
           result <= {result[30:0], 1'b0};  
         end  
         if (cycle == 0) begin  
           active <= 0;  
         end  
         cycle <= cycle - 5'd1;  
       end  
       else begin  
         // Set up for an unsigned divide.  
         cycle <= 5'd31;  
         result <= A;  
         denom <= B;  
         work <= 32'b0;  
         active <= 1;  
       end  
     end  
   end  
 endmodule 
