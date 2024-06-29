module vga_display (
	input [6:0] select,
	input overflow,
    input wire clk,
    input wire reset,
    input [3:0] uni,
    input [3:0] ten,
    input [3:0] hun,
    input [3:0] tho,
	
	input [3:0] tt,
    input [3:0] ht,
    input [3:0] mil,
    input [3:0] tmil,
	input negative,
	input [4:0] state,
    output wire hsync,
    output wire vsync,
    output wire red,
    output wire green,
    output wire blue
);

wire clk_25MHz;
/*
always @(posedge clk or negedge reset) begin
    if (!reset)
        clk_25MHz <= 0;
    else
        clk_25MHz <= ~clk_25MHz;
end
*/

pll_25 pll_25_i(
	.inclk0(clk),
	.c0(clk_25MHz),
	.locked()
	
	);







localparam H_ACTIVE = 640;
localparam H_FRONT = 16;
localparam H_SYNC = 96;
localparam H_BACK = 48;
localparam H_TOTAL = 800;

localparam V_ACTIVE = 480;
localparam V_FRONT = 10;
localparam V_SYNC = 2;
localparam V_BACK = 33;
localparam V_TOTAL = 525;
localparam FONT_W  = 16;
localparam FONT_H  = 16;
localparam POS_Y   =256;
localparam OFFSET_X=128;


reg [9:0] h_count = 0;
reg [9:0] v_count = 0;
reg [3:0] uni_r;
reg [3:0] ten_r;
reg [3:0] hun_r;
reg [3:0] tho_r;
reg [3:0] tt_r;
reg [3:0] ht_r;
reg [3:0] mil_r;
reg [3:0] tmil_r;




always @(posedge clk_25MHz /*or negedge reset*/) begin
    if (!reset) begin
        h_count <= 0;
        v_count <= 0;
    end else begin
        if (h_count == H_TOTAL - 1) begin
            h_count <= 0;
            if (v_count == V_TOTAL - 1)
                v_count <= 0;
            else
                v_count <= v_count + 1;
        end else begin
            h_count <= h_count + 1;
        end
    end
end

assign hsync = (h_count >= H_ACTIVE + H_FRONT) && (h_count < H_ACTIVE + H_FRONT + H_SYNC);
assign vsync = (v_count >= V_ACTIVE + V_FRONT) && (v_count < V_ACTIVE + V_FRONT + V_SYNC);

reg [FONT_W-1:0] char_rom [0:10][0:FONT_H-1];
initial begin
//0
    char_rom[0][ 0] = 16'b0000000000000000;
    char_rom[0][ 1] = 16'b0000011111100000;
    char_rom[0][ 2] = 16'b0001111111111000;
    char_rom[0][ 3] = 16'b0011100000011100;
    char_rom[0][ 4] = 16'b0011100000011100;
    char_rom[0][ 5] = 16'b0011100000011100;
    char_rom[0][ 6] = 16'b0011100000011100;
    char_rom[0][ 7] = 16'b0011100000011100;
    char_rom[0][ 8] = 16'b0011100000011100;
    char_rom[0][ 9] = 16'b0011100000011100;
    char_rom[0][10] = 16'b0011100000011100;
    char_rom[0][11] = 16'b0011100000011100;
    char_rom[0][12] = 16'b0011111111111000;
    char_rom[0][13] = 16'b0000111111100000;
    char_rom[0][14] = 16'b0000000000000000;
    char_rom[0][15] = 16'b0000000000000000;

    char_rom[1][ 0] = 16'b0000000000000000;
    char_rom[1][ 1] = 16'b0000001111000000;
    char_rom[1][ 2] = 16'b0000111111000000;
    char_rom[1][ 3] = 16'b0011111111000000;
    char_rom[1][ 4] = 16'b0000001111000000;
    char_rom[1][ 5] = 16'b0000001111000000;
    char_rom[1][ 6] = 16'b0000001111000000;
    char_rom[1][ 7] = 16'b0000001111000000;
    char_rom[1][ 8] = 16'b0000001111000000;
    char_rom[1][ 9] = 16'b0000001111000000;
    char_rom[1][10] = 16'b0000001111000000;
    char_rom[1][11] = 16'b0000001111000000;
    char_rom[1][12] = 16'b0000001111000000;
    char_rom[1][13] = 16'b0000001111000000;
    char_rom[1][14] = 16'b0000000000000000;
    char_rom[1][15] = 16'b0000000000000000;
//2
    char_rom[2][ 0] = 16'b0000000000000000;
    char_rom[2][ 1] = 16'b0000011111110000;
    char_rom[2][ 2] = 16'b0001110000111000;
    char_rom[2][ 3] = 16'b0011100000011100;
    char_rom[2][ 4] = 16'b0011100000011100;
    char_rom[2][ 5] = 16'b0000000000011100;
    char_rom[2][ 6] = 16'b0000000000111000;
    char_rom[2][ 7] = 16'b0000000001111000;
    char_rom[2][ 8] = 16'b0000000011110000;
    char_rom[2][ 9] = 16'b0000000111100000;
    char_rom[2][10] = 16'b0000001111000000;
    char_rom[2][11] = 16'b0000111110000000;
    char_rom[2][12] = 16'b0001111111111100;
    char_rom[2][13] = 16'b0011111111111100;
    char_rom[2][14] = 16'b0000000000000000;
    char_rom[2][15] = 16'b0000000000000000;

    char_rom[3][ 0] = 16'b0000000000000000;
    char_rom[3][ 1] = 16'b0000111111110000;
    char_rom[3][ 2] = 16'b0001111111111000;
    char_rom[3][ 3] = 16'b0011100000011100;
    char_rom[3][ 4] = 16'b0011100000011100;
    char_rom[3][ 5] = 16'b0000000000011100;
    char_rom[3][ 6] = 16'b0000000000111000;
    char_rom[3][ 7] = 16'b0000001111110000;
    char_rom[3][ 8] = 16'b0000001111111000;
    char_rom[3][ 9] = 16'b0000000000011100;
    char_rom[3][10] = 16'b0111000000011100;
    char_rom[3][11] = 16'b0111000000011100;
    char_rom[3][12] = 16'b0011111111111000;
    char_rom[3][13] = 16'b0001111111110000;
    char_rom[3][14] = 16'b0000000000000000;
    char_rom[3][15] = 16'b0000000000000000;

    char_rom[4][ 0] = 16'b0000000000000000;
    char_rom[4][ 1] = 16'b0000000001111100;
    char_rom[4][ 2] = 16'b0000000011111100;
    char_rom[4][ 3] = 16'b0000000111011100;
    char_rom[4][ 4] = 16'b0000001110011100;
    char_rom[4][ 5] = 16'b0000011100011100;
    char_rom[4][ 6] = 16'b0000111000011100;
    char_rom[4][ 7] = 16'b0001110000011100;
    char_rom[4][ 8] = 16'b0011100000011100;
    char_rom[4][ 9] = 16'b0111111111111100;
    char_rom[4][10] = 16'b0111111111111100;
    char_rom[4][11] = 16'b0000000000011100;
    char_rom[4][12] = 16'b0000000000011100;
    char_rom[4][13] = 16'b0000000000011100;
    char_rom[4][14] = 16'b0000000000000000;
    char_rom[4][15] = 16'b0000000000000000;

    char_rom[5][ 0] = 16'b0000000000000000;
    char_rom[5][ 1] = 16'b0011111111111000;
    char_rom[5][ 2] = 16'b0111111111111000;
    char_rom[5][ 3] = 16'b0111000000000000;
    char_rom[5][ 4] = 16'b0111000000000000;
    char_rom[5][ 5] = 16'b0111000000000000;
    char_rom[5][ 6] = 16'b0111111111100000;
    char_rom[5][ 7] = 16'b0011111111111000;
    char_rom[5][ 8] = 16'b0000000000011100;
    char_rom[5][ 9] = 16'b0000000000011100;
    char_rom[5][10] = 16'b0111000000011100;
    char_rom[5][11] = 16'b0111000000011100;
    char_rom[5][12] = 16'b0011111111111000;
    char_rom[5][13] = 16'b0001111111110000;
    char_rom[5][14] = 16'b0000000000000000;
    char_rom[5][15] = 16'b0000000000000000;

    char_rom[6][ 0] = 16'b0000000000000000;
    char_rom[6][ 1] = 16'b0000111111110000;
    char_rom[6][ 2] = 16'b0001111111111000;
    char_rom[6][ 3] = 16'b0011110000111000;
    char_rom[6][ 4] = 16'b0111100000000000;
    char_rom[6][ 5] = 16'b0111100000000000;
    char_rom[6][ 6] = 16'b0111100000000000;
    char_rom[6][ 7] = 16'b0111111111110000;
    char_rom[6][ 8] = 16'b0111111111111000;
    char_rom[6][ 9] = 16'b0111100000111100;
    char_rom[6][10] = 16'b0111000000011100;
    char_rom[6][11] = 16'b0111100000111100;
    char_rom[6][12] = 16'b0011111111111000;
    char_rom[6][13] = 16'b0001111111110000;
    char_rom[6][14] = 16'b0000000000000000;
    char_rom[6][15] = 16'b0000000000000000;

    char_rom[7][ 0] = 16'b0000000000000000;
    char_rom[7][ 1] = 16'b0111111111111100;
    char_rom[7][ 2] = 16'b0111111111111100;
    char_rom[7][ 3] = 16'b0000000000111100;
    char_rom[7][ 4] = 16'b0000000001111000;
    char_rom[7][ 5] = 16'b0000000011110000;
    char_rom[7][ 6] = 16'b0000000111100000;
    char_rom[7][ 7] = 16'b0000001111000000;
    char_rom[7][ 8] = 16'b0000011110000000;
    char_rom[7][ 9] = 16'b0000111100000000;
    char_rom[7][10] = 16'b0001111000000000;
    char_rom[7][11] = 16'b0011110000000000;
    char_rom[7][12] = 16'b0111100000000000;
    char_rom[7][13] = 16'b0111000000000000;
    char_rom[7][14] = 16'b0000000000000000;
    char_rom[7][15] = 16'b0000000000000000;

    char_rom[8][ 0] = 16'b0000000000000000;
    char_rom[8][ 1] = 16'b0001111111110000;
    char_rom[8][ 2] = 16'b0011111111111000;
    char_rom[8][ 3] = 16'b0111110000111100;
    char_rom[8][ 4] = 16'b0111100000011100;
    char_rom[8][ 5] = 16'b0011110000111100;
    char_rom[8][ 6] = 16'b0001111111110000;
    char_rom[8][ 7] = 16'b0011111111111000;
    char_rom[8][ 8] = 16'b0111100000111100;
    char_rom[8][ 9] = 16'b0111000000011100;
    char_rom[8][10] = 16'b0111000000011100;
    char_rom[8][11] = 16'b0111100000111100;
    char_rom[8][12] = 16'b0011111111111000;
    char_rom[8][13] = 16'b0001111111110000;
    char_rom[8][14] = 16'b0000000000000000;
    char_rom[8][15] = 16'b0000000000000000;

    char_rom[9][ 0] = 16'b0000000000000000;
    char_rom[9][ 1] = 16'b0001111111110000;
    char_rom[9][ 2] = 16'b0011111111111000;
    char_rom[9][ 3] = 16'b0111000000011100;
    char_rom[9][ 4] = 16'b0111000000011100;
    char_rom[9][ 5] = 16'b0111000000011100;
    char_rom[9][ 6] = 16'b0011100001111100;
    char_rom[9][ 7] = 16'b0000111111111100;
    char_rom[9][ 8] = 16'b0000000000011100;
    char_rom[9][ 9] = 16'b0000000000011100;
    char_rom[9][10] = 16'b0111000000011100;
    char_rom[9][11] = 16'b0111000000011100;
    char_rom[9][12] = 16'b0011111111111000;
    char_rom[9][13] = 16'b0001111111110000;
    char_rom[9][14] = 16'b0000000000000000;
    char_rom[9][15] = 16'b0000000000000000;
	
	char_rom[10][ 0] = 16'b0000000000000000;
    char_rom[10][ 1] = 16'b0000000000000000;
    char_rom[10][ 2] = 16'b0000000000000000;
    char_rom[10][ 3] = 16'b0000000000000000;
    char_rom[10][ 4] = 16'b0000000000000000;
    char_rom[10][ 5] = 16'b0000000000000000;
    char_rom[10][ 6] = 16'b0000000000000000;
    char_rom[10][ 7] = 16'b0111111111111100;
    char_rom[10][ 8] = 16'b0111111111111100;
    char_rom[10][ 9] = 16'b0000000000000000;
    char_rom[10][10] = 16'b0000000000000000;
    char_rom[10][11] = 16'b0000000000000000;
    char_rom[10][12] = 16'b0000000000000000;
    char_rom[10][13] = 16'b0000000000000000;
    char_rom[10][14] = 16'b0000000000000000;
    char_rom[10][15] = 16'b0000000000000000;

	

end

wire display_area = (h_count < H_ACTIVE) && (v_count < V_ACTIVE);

reg [FONT_W-1:0] char_line;
always @(posedge clk_25MHz) begin

    uni_r <= (uni<=9)?uni:0;
	ten_r <= (ten<=9)?ten:0;
	hun_r <= (hun<=9)?hun:0;
	tho_r <= (tho<=9)?tho:0;
    ht_r <=  (ht<=9)?ht:0;
	tt_r <= (tt<=9)?tt:0;
	mil_r <= (mil<=9)?mil:0;
	tmil_r <= (tmil<=9)?tmil:0;
	
    if (display_area) begin
        if ((v_count >= POS_Y && v_count < POS_Y+FONT_H) /*&& (h_count>=OFFSET_X)*/) begin
		
			if(overflow) begin
			    case ((h_count - OFFSET_X) / FONT_W)
				0: char_line <=0 ;
				1: char_line <=char_rom[10][v_count - POS_Y]; 
				2: char_line <=char_rom[10][v_count - POS_Y]; 
				3: char_line <=char_rom[10][v_count - POS_Y];
				4: char_line <=char_rom[10][v_count - POS_Y];
				5: char_line <=char_rom[10][v_count - POS_Y]; 
				6: char_line <=char_rom[10][v_count - POS_Y]; 
				7: char_line <=char_rom[10][v_count - POS_Y];
				8: char_line <=char_rom[10][v_count - POS_Y];
				
                default: char_line <= 0;
            endcase
			
			end else begin
            case ((h_count - OFFSET_X) / FONT_W)
				0: char_line<= ~negative?char_rom[10][v_count - POS_Y]:0;
				1: char_line <= (tmil_r<=9)?char_rom[tmil_r][v_count - POS_Y]:char_rom[0][v_count - POS_Y]; 
				2: char_line <= (mil_r<=9)?char_rom[mil_r][v_count - POS_Y]:char_rom[0][v_count - POS_Y]; 
				3: char_line <= (ht_r<=9)?char_rom[ht_r][v_count - POS_Y]:char_rom[0][v_count - POS_Y];
				4: char_line <= (tt_r<=9)?char_rom[tt_r][v_count - POS_Y]:char_rom[0][v_count - POS_Y];
				5: char_line <= (tho_r<=9)?char_rom[tho_r][v_count - POS_Y]:char_rom[0][v_count - POS_Y]; 
				6: char_line <= (hun_r<=9)?char_rom[hun_r][v_count - POS_Y]:char_rom[0][v_count - POS_Y]; 
				7: char_line <= (ten_r<=9)?char_rom[ten_r][v_count - POS_Y]:char_rom[0][v_count - POS_Y];
				8: char_line <= (uni_r<=9)?char_rom[uni_r][v_count - POS_Y]:char_rom[0][v_count - POS_Y];
				
                default: char_line <= 0;
            endcase
			end
			
			
        end else begin
            char_line <= 0;
        end
		
		
    end else begin
        char_line <= 0;
    end
	
	
end

wire pixel = char_line[FONT_W-1 - (h_count % FONT_W)];

assign red = (display_area) ? 1'b1 : 1'b0;
assign green = (display_area && ~pixel) ? 1'b1 : 1'b0;
assign blue = (0) ? 1'b1 : 1'b0;

endmodule
