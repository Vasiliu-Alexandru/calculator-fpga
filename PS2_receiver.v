`define key0 8'h45
`define key1 8'h16
`define key2 8'h1e
`define key3 8'h26
`define key4 8'h25
`define key5 8'h2e
`define key6 8'h36
`define key7 8'h3d
`define key8 8'h3e
`define key9 8'h46

`define key0x 8'h70
`define key1x 8'h69
`define key2x 8'h72
`define key3x 8'h7a
`define key4x 8'h6b
`define key5x 8'h73
`define key6x 8'h74
`define key7x 8'h6c
`define key8x 8'h75
`define key9x 8'h7d

`define enter 8'h5a
`define plus	 8'h55
`define plus2	 8'h79
`define produs 8'h07c
`define minus 8'h4e
`define minus2 8'h7b
`define divide 8'h4a
`define putere 8'h4d
`define radical 8'h2d // r
`define factorial 8'h2b // f
`define key_release 8'h0f
`define escape     8'h76

`define Start  4'd0 
`define SB0    4'd1
`define SB1    4'd2
`define SB2    4'd3
`define SB3    4'd4
`define SB4    4'd5
`define SB5    4'd6
`define SB6    4'd7
`define SB7    4'd8
`define Parity 4'd9
`define Stop   4'd10
 
`timescale 1ns/1ps

module PS2_receiver(
  input rst,
  input ps2_clk,
  input ps2_data,
  output reg [4:0] dec_data,
  output [3:0] c_s,
  output  flag
  );
  
  reg [3:0] state_reg,state_nxt;
  
  reg flag_ff,flag_nxt; 
  reg [7:0] data_nxt, data_ff;
  assign c_s=state_reg;
  always@(negedge ps2_clk) begin
    if(!rst) begin
      state_reg<=`Start;
	  data_ff<=8'h00;
	  flag_ff<=0;
  end else begin
      state_reg<=state_nxt;
	  data_ff<=data_nxt;
	  flag_ff<=flag_nxt;
  end 
end  
  
  always @(*) begin
 
	data_nxt = data_ff;
	state_nxt = state_reg;
	flag_nxt = 1'b0; 
	
    case(state_reg)
      
      `Start: begin if(ps2_data==0)
        state_nxt=`SB0;
       end
       
      `SB0: begin 
        state_nxt=`SB1;
        data_nxt[0]=ps2_data;
       end
            
      `SB1: begin 
        state_nxt=`SB2;
        data_nxt[1]=ps2_data;
       end
       
       `SB2: begin 
        state_nxt=`SB3;
        data_nxt[2]=ps2_data;
       end
       
       `SB3: begin 
        state_nxt=`SB4;
        data_nxt[3]=ps2_data;
       end
       
       `SB4: begin 
        state_nxt=`SB5;
        data_nxt[4]=ps2_data;
       end
       
       `SB5: begin 
        state_nxt=`SB6;
        data_nxt[5]=ps2_data;
       end
      
      `SB6: begin 
        state_nxt=`SB7;
        data_nxt[6]=ps2_data;
       end
       
      `SB7: begin 
        state_nxt=`Parity;
        data_nxt[7]=ps2_data;
       end

      `Parity: begin 
        state_nxt=`Stop;
        flag_nxt	=1'b1;
       end
       
       `Stop: begin 
        state_nxt=`Start;
       
       end
      default: state_nxt=`Start;
      
    endcase  
	
		
    end
  
  
  always @(*) begin	
	case(data_ff) 
    `key0, `key0x:  	  dec_data=5'b00000;
    `key1, `key1x:  	  dec_data=5'b00001;
    `key2, `key2x:  	  dec_data=5'b00010;
    `key3, `key3x:        dec_data=5'b00011;
    `key4, `key4x:  	  dec_data=5'b00100;   
    `key5, `key5x:  	  dec_data=5'b00101;
    `key6, `key6x:        dec_data=5'b00110;   
    `key7, `key7x:        dec_data=5'b00111;
    `key8, `key8x:        dec_data=5'b01000;
    `key9, `key9x:        dec_data=5'b01001;
 	`enter:               dec_data=5'b01010;

	`plus, `plus2:        dec_data=5'b01011;
 	`minus,`minus2:       dec_data=5'b01100;
	
	`produs :     dec_data=5'b01101;
	`divide:      dec_data=5'b01110;
	`factorial:   dec_data=5'b01111;
	`putere:      dec_data=5'b10000;
	`radical:     dec_data=5'b10001;
	`escape:      dec_data=5'b10010;
	`key_release: dec_data=5'b11110;
    default:      dec_data=5'b11111;
    endcase
  end
 
  assign  flag=flag_ff;

  
  
endmodule