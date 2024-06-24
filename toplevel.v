module toplevel(
  input clk_50Mhz,
  input rst,
  input ps2_clk,
  input ps2_data,
  output [7:0] segments,
  output [3:0] digits,
  // output [4:0] state,
  output [2:0] a_t,
  output sign_out,
  output hsync,
  output vsync,
  output red,
  output green,
  output blue
);
  reg [27:0] data_out_ff, data_out_nxt;

  wire [4:0] data;
  wire cifra_noua;
  wire cifra_noua_sync;
  wire [7:0] select;
  wire [4:0] c_s;
  reg [3:0] hex_sel;
  // assign state=~c_s;
  assign digits = ~hex_sel;
  wire [27:0] a, b, data_out, afisare;

  wire [3:0] tmil ,  mil, ht , tt,  th, hun, tens,     uts;
  reg [12:0] clks_ff;
  wire clks;
  wire valid;
  wire [2:0] led;
  assign segments[7] = 1'b1;
  assign clks = clks_ff[12];

  always @(posedge clk_50Mhz) begin
    if (!rst) begin
      clks_ff <= 0;
      data_out_ff <= 0;
    end else begin
      clks_ff <= clks_ff + 1;
      data_out_ff = data_out_nxt;
      /*
      if (select[4]) begin
        data_out_nxt <= data_out;
      end else begin
        data_out_nxt <= a;
      end
      */
    end
  end

  PS2_receiver U1 (
    .rst(rst),
    .ps2_clk(ps2_clk), // 100Khz
    .ps2_data(ps2_data),
    .dec_data(data), // 100kHz
    .c_s(),
    .flag(cifra_noua) // 100kHz
  );

  clock_sync u3 (
    .clk(clk_50Mhz), // 50 Mhz
    .signal(cifra_noua),
    .posedge_detected(cifra_noua_sync) // 50MHz
  );

/*
VGA u5(
.clock(clk_50Mhz),
.switch(),
.disp_RGB({red,green,blue}),
.hsync(hsync),
.vsync(vsync)

);
*/

vga_display
(
   .clk(clk_50Mhz),
   .reset(rst),
   .uni(uts),
   .ten(tens),
   .hun(hun),
   .tho(th),
   .tt(tt),
   .ht(ht),
   .mil(mil),
   .tmil(tmil),
   
                 //       tmil ,  mil, ht , tt,  th, hun, tens,uts
   
   
   .hsync(hsync),
   .vsync(vsync),
   .red(red),
   .green(green),
   .blue(blue)
);

  formnumber u4 (
    .clk(clk_50Mhz),
    .rst(rst),
    .data(data),
    .cifra_noua(cifra_noua_sync),
    .a(a),
    .b(b),
    .select_final(select),
    .c_s(c_s),
    .afisare(afisare),
    .sign_out(sign_out),
    .led(led)
  );

  wire [27:0] dat;
  assign dat = data_out_ff;

/*
  bin_2_bcd u6 (
    .d_in(afisare[15:0]),
    .thousands(th),
    .hundreds(hun),
    .tens(tens),
    .units(uts)
  );
  */
  
 bin2bcd u8(
    .bin(afisare), // signed integer
    .valid_in(1), 
    .clk(clk_50Mhz),
    .rst(rst),
    .valid_out(),
    .bcd({tmil ,  mil, ht , tt,  th, hun, tens,uts}), // 8 4-bit digits
    .sign() // 1 if the number is negative
);


  // 50Hz (slow clock)
  always @(posedge clks, negedge rst) begin
    if (!rst) begin
      hex_sel <= 4'b0001;
    end else begin
      if (hex_sel == 4'b1000)
        hex_sel <= 4'b0001;
      else
        hex_sel <= (hex_sel << 1);
    end
  end

  wire [3:0] hex_in;
  assign hex_in = (hex_sel == 4'b0001) ? uts :
                  (hex_sel == 4'b0010) ? tens :
                  (hex_sel == 4'b0100) ? hun : th;

  hex2segments U6 (
    .n(hex_in[3:0]),
    .segments(segments[6:0])
  );

  assign a_t = ~led;

endmodule
