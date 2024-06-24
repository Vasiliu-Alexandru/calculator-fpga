module square_root
    #(parameter N = 28)
    (   input clk,  
        input rst,   
		input valid_in,
        input signed [N-1:0] num_in,  
        output reg done,     
        output reg [N/2-1:0] sq_root, 
        output reg eroare
    );

    reg [N-1:0] a;
    reg [N/2+1:0] left,right;    
    reg signed [N/2+1:0] r;
    reg [N/2-1:0] q;  
    integer i;

    always @(posedge clk or negedge rst) 
    begin
        if (!rst) begin 
            done <= 0;
            sq_root <= 0;
            i = 0;
            a = 0;
            left = 0;
            right = 0;
            r = 0;
            q = 0;
            eroare = 0;
        end    
        else begin
            if((num_in < 0) && valid_in) begin
                eroare <= 1;
            end
            else begin
                if(i == 0 && valid_in) begin  
                    a = num_in;
                    done <= 0;    
                    i = i+1;   
                end
                else if(i < N/2) begin 
                    i = i+1;  
                end
                right = {q,r[N/2+1],1'b1};
                left = {r[N/2-1:0], a[N-1:N-2]};
                a = {a[N-3:0], 2'b0};  
                if ( r[N/2+1] == 1)   
                    r = left + right;
                else
                    r = left - right;
                q = {q[N/2-2:0], ~r[N/2+1]};
                if(i == N/2) begin   
                    done <= 1;   
                    i = 0; 
                    sq_root <= q;  
                    left = 0;
                    right = 0;
                    r = 0;
                    q = 0;
                end else begin
  	  			    done <= 0;
				end
            end
        end   
    end

endmodule
