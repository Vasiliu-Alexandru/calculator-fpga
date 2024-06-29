
`define Init     5'd0     //stari
`define cifra_a     5'd1
`define wait_timer_a	     5'd2
`define wait_timer_b 5'd3
`define cifra_b 5'd4
`define calculation 5'd5
`define wait_timer_enter 5'd6
`define st_divide 5'd7
`define st_radical 5'd8
`define st_factorial 5'd9
`define st_putere 5'd10
`define st_diferenta 5'd11
`define st_produs 5'd12
`define st_suma 5'd13
`define error 5'd14






`define plus      5'b01011   //operatori
`define minus     5'b01100
`define produs    5'b01101
`define divide    5'b01110
`define factorial 5'b01111
`define putere    5'b10000
`define op_radical   5'b10001
`define enter     5'b01010
`define escape    5'b10010
`define keyrelease 5'b11110


module formnumber(
   input clk,
   input rst,
   input [4:0] data,
   input cifra_noua,
  output signed [27:0] a,
  output signed [27:0] b,
   output reg [6:0] select_final,
//   output  valid,
   output [4:0] c_s,
   output  signed  [27:0] afisare,
   output sign_out,
   output [2:0] led,
   output reg overflow
);



assign select_out=select_reg;
	reg [28:0] rezultat_suma; 
	reg [53:0] rezultat_produs;
localparam TIMER_W = 23;
reg [4:0] state_reg,state_nxt;
reg valid_reg,valid_nxt;
reg signed [27:0] output1_reg,output1_nxt, output2_reg,output2_nxt;
reg signed [27:0] rez_reg,rez_nxt;
reg [27:0] afisare_reg,afisare_nxt;
assign afisare=afisare_reg;
assign a=output1_reg;
assign b=output2_reg;
assign c_s=state_reg;
wire [27:0] rezultat_factorial,rezultat_putere,rezultat_radical,rezultat_impartire;
//assign valid=valid_reg;
reg a_negative,b_negative;
reg [6:0] select_nxt,select_reg;
wire putere_valid;
reg [TIMER_W:0] cnt_reg,cnt_nxt;
reg sign;
assign sign_out=sign;

wire ovr_fact,ovr_imp,ovr_put;
wire fct_valid;
 factorial u1(
    .n(output1_reg),  
    .valid_in(select_reg[2]),  	  
    .clk(clk),
    .rst(rst),
    .valid_out(fct_valid),
    .ovrflow(ovr_fact),       
    .d_out(rezultat_factorial)   
);

putere u2(
     .n1(output1_reg),  
     .n2(output2_reg),
     .valid_in(select_reg[1]),  	   
     .clk(clk),
     .rst(rst),
     .valid_out(putere_valid),
     .ovrflow(ovr_put),      
     .d_out(rezultat_putere)  
);

wire div_valid;
impartire u3(
     .n1(output1_reg),  
     .n2(output2_reg),
     .valid_in(select_reg[3]),  	    
     .clk(clk),
     .rst(rst),
     .valid_out(div_valid),
     .err(ovr_imp),         
     .d_out(rezultat_impartire)  

);
wire sqr_valid;
square_root u4
    (   .clk(clk),  
        .rst(rst), 
		.valid_in(select_reg[0]),
        .num_in(output1_reg),  
        .done(sqr_valid),     
        .sq_root(rezultat_radical), 
        .eroare()
    );


always @(posedge clk, negedge rst) begin
	if(!rst) begin
		state_reg<=`Init;
		output1_reg<=0;
		output2_reg<=0;
		cnt_reg<=0;
		rez_reg<=0;
		select_reg<=0;
		afisare_reg<=0;
		
	end else begin
		state_reg<=state_nxt;
		output1_reg<=output1_nxt;
		output2_reg<=output2_nxt;
		cnt_reg<=cnt_nxt;
		rez_reg<=rez_nxt;
		select_reg<=select_nxt;
		afisare_reg<=afisare_nxt;
	end
end

always @(*) begin

	rezultat_suma=0;
	rezultat_produs=0;
	state_nxt = state_reg;
	afisare_nxt=afisare_reg;
	valid_nxt= 0;
	a_negative=1'b0;
	b_negative=1'b0;
    output1_nxt=output1_reg;	
    output2_nxt=output2_reg;
	cnt_nxt=cnt_reg;	
	select_nxt=select_reg;
	select_final=7'd0;
	rez_nxt=rez_reg;
	sign=1;
	overflow=0;
case(state_reg)

    `Init: begin
		output1_nxt=0;
		output2_nxt=0;
		state_nxt=`cifra_a;
		cnt_nxt=0;
	end
    
    `cifra_a: begin 
		if(cifra_noua && data[4:0]<=9) begin
			if(output1_reg<=9999999) output1_nxt=output1_reg*10+data[4:0];
			cnt_nxt=0;
			state_nxt=`wait_timer_a;
			end else
		if(cifra_noua) begin
			case(data[4:0])
				`plus: begin //+
					select_nxt=7'b1000000;		
					state_nxt=`cifra_b;
				end
				
				`minus: begin
					select_nxt = 7'b0100000;
					state_nxt = `cifra_b;
				end
				
				`produs: begin
					select_nxt = 7'b0010000;
					state_nxt = `cifra_b;
				end
				
				`divide: begin
					select_nxt = 7'b0001000;
					state_nxt = `cifra_b;
				end
				
				`factorial: begin
					select_nxt = 7'b0000100;
					state_nxt = `calculation;
				end
				
				`putere: begin
					select_nxt = 7'b0000010;
					state_nxt = `cifra_b;
				end
				
				`op_radical: begin
					select_nxt = 7'b0000001;
					state_nxt = `calculation;
				end
				
				default:state_nxt=`cifra_a; 	
				
			endcase
		end
		afisare_nxt=output1_reg[27:0];
    end

	`wait_timer_a: begin 
		cnt_nxt=cnt_reg+1;
		if(cnt_reg[TIMER_W]) begin
		state_nxt=`cifra_a;
		end
		afisare_nxt=output1_reg[27:0];
	end
	
	`wait_timer_b: begin 
		cnt_nxt=cnt_reg+1;
		if(cnt_reg[TIMER_W]) begin
		state_nxt=`cifra_b;
		end
		afisare_nxt=output2_reg[27:0];
	end
	
	`wait_timer_enter: begin 
		cnt_nxt=cnt_reg+1;
		if(cnt_reg[TIMER_W]) begin
			state_nxt = `calculation;
			end
	
	end
		
	
 `cifra_b: begin 
		
		if(cifra_noua && data[4:0]<=9) begin
			if(output2_reg<=9999999) output2_nxt=output2_reg*10+data[4:0];
			cnt_nxt=0;
			state_nxt=`wait_timer_b;
			end 

		if (cifra_noua && data[4:0] == `enter) begin
			state_nxt = `calculation;
		end
		afisare_nxt=output2_reg[27:0];
end
	
	`calculation: begin
		select_final=select_reg;


			if(select_reg[4]) begin 
				state_nxt=`st_produs;
			end
			if(select_reg[6])  begin
				state_nxt=`st_suma;
			end
			
			
			if(select_reg[5])  begin
				state_nxt=`st_diferenta;
			end


			if(select_reg[3]) begin
				state_nxt=`st_divide;
			end
			if(select_reg[2]) begin
				state_nxt=`st_factorial;
			end
			if(select_reg[1]) begin
				state_nxt=`st_putere;
			end
			
			if(select_reg[0]) begin
				state_nxt=`st_radical;
			end
			
			
	end
	`st_divide: begin
			if(div_valid) begin
				afisare_nxt=rezultat_impartire;
			end
			if(ovr_imp)
				overflow=1;
	
	end
	`st_factorial: begin
			if(fct_valid) begin
				afisare_nxt=rezultat_factorial;
			end
			if(ovr_fact)
				overflow=1;
	
	end
	`st_radical: begin
			if(sqr_valid) begin
				afisare_nxt=rezultat_radical;
			end
	
	end
	
	`st_putere: begin
		if(putere_valid) begin
			afisare_nxt=rezultat_putere;
		end
		if(ovr_put)
			overflow=1;
	
	end
	
		`st_diferenta: begin
			afisare_nxt=(output1_reg[27:0]<output2_reg[27:0])?(output2_reg[27:0]-output1_reg[27:0]):(output1_reg[27:0]-output2_reg[27:0]);
			sign = ~(output1_reg[27:0]<output2_reg[27:0]);

			if(cifra_noua) begin
				output1_nxt=afisare_nxt;
			    output2_nxt=0;
				state_nxt=`cifra_a;
				overflow=0;
				
			end
		
	end
	
	
	`st_suma: begin
		rezultat_suma=output1_reg[27:0]+output2_reg[27:0];
		if(rezultat_suma>99999999) begin 
			overflow=1;
			state_nxt=`error;
		end
		afisare_nxt=output1_reg[27:0]+output2_reg[27:0];
		output1_nxt=afisare_nxt;
		output2_nxt=0;
		if(cifra_noua) begin
			state_nxt=`cifra_a;
			overflow=0;
		end
	end
	
	`st_produs: begin
		rezultat_produs=output1_reg[27:0]*output2_reg[27:0];
		if(rezultat_produs>99999999) begin overflow=1
			state_nxt=`error;
		end 
	
		afisare_nxt=output1_reg[27:0]*output2_reg[27:0];
		output1_nxt=afisare_nxt;
		output2_nxt=1;
		if(cifra_noua) begin
			state_nxt=`cifra_a;
			overflow=0;
			output2_nxt=0;

		end
		
	end
	`error: begin
		overflow=1;
	end
	default: state_nxt=`Init;
endcase



if(cifra_noua && data[4:0]==`escape) begin
	state_nxt=`Init;
end
end
//assign a=output1_reg;

assign led={select_reg[6:5],select_reg[0]};
endmodule

