`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2018 08:32:13 PM
// Design Name: 
// Module Name: char_rec
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module char_rec(
        input clk,
        input start,
        output done,
        
        output reg[14:0] img_ram_addr,
        input[11:0] img_ram_data,
                
        output reg[323:0] recg_sudoku
                           
    );

parameter IMG_WIDTH = 144;
parameter DELAY_CYCLES = 2;
    
// States
parameter IDLE = 0;
parameter RECG = 1;
parameter RECONF = 2;

reg[3:0] state = 0;
 
reg[11:0] cycle_counter = 0;
reg[8:0] mem_addr_counter = 0;
reg[8:0] x0 = 0;
reg[8:0] y0 = 0;
reg[4:0] hcount = 0;
reg[4:0] vcount = 0;

wire[8:0] x = hcount + x0;
wire[8:0] y = vcount + y0;

// Probabilities

reg[8:0] none_score = 0;
reg[8:0] one_score = 0;
reg[8:0] two_score = 0;
reg[8:0] three_score = 0;
reg[8:0] four_score = 0;
reg[8:0] five_score = 0;
reg[8:0] six_score = 0;
reg[8:0] seven_score = 0;
reg[8:0] eight_score = 0;
reg[8:0] nine_score = 0;

//assign img_ram_addr = x + (y * IMG_WIDTH);

parameter THRESHOLD = 20;
parameter CELL_LR_WIDTH = 16;

wire[5:0] combined_pixel_data = img_ram_data[3:0] + img_ram_data[7:4] + img_ram_data[11:8];
wire pix_logical = combined_pixel_data > THRESHOLD;

wire[3:0] max_score;

max_score max_score_1 (
    .none_score(none_score),
    .one_score(one_score),
    .two_score(two_score),
    .three_score(three_score),
    .four_score(four_score),
    .five_score(five_score),
    .six_score(six_score),
    .seven_score(seven_score),
    .eight_score(eight_score),
    .nine_score(nine_score),
    .max_score_out(max_score));
    
// ROMs

wire one_d;
wire two_d;
wire three_d;
wire four_d;
wire five_d;
wire six_d;
wire seven_d;
wire eight_d;
wire nine_d;
    
reg[7:0] rom_addr = 0;

one_16_d one_16_d_1 (
    .clka(clk),
    .addra(rom_addr),
    .douta(one_d));
    
two_16_d two_16_d_1 (
    .clka(clk),
    .addra(rom_addr),
    .douta(two_d));
    
three_16_d three_16_d_1 (
    .clka(clk),
    .addra(rom_addr),
    .douta(three_d));
    
four_16_d four_16_d_1 (
    .clka(clk),
    .addra(rom_addr),
    .douta(four_d));
    
five_16_d five_16_d_1 (
    .clka(clk),
    .addra(rom_addr),
    .douta(five_d));
    
six_16_d six_16_d_1 (
    .clka(clk),
    .addra(rom_addr),
    .douta(six_d));
    
seven_16_d seven_16_d_1 (
    .clka(clk),
    .addra(rom_addr),
    .douta(seven_d));
    
eight_16_d eight_16_d_1 (
    .clka(clk),
    .addra(rom_addr),
    .douta(eight_d));
    
nine_16_d nine_16_d_1 (
    .clka(clk),
    .addra(rom_addr),
    .douta(nine_d));
    
always @(posedge clk) begin
    img_ram_addr <= x + y * IMG_WIDTH;
    rom_addr <= ((hcount < 16) && (vcount < 16)) ? hcount + (vcount * CELL_LR_WIDTH) : 255;
    case(state)
        IDLE: begin
            if(start) begin
                state <= RECG;
                cycle_counter <= 0;
                mem_addr_counter <= 0;
                recg_sudoku <= 0;
                x0 <= 0;
                y0 <= 0;
                hcount <= 0;
		vcount <= 0;

                none_score  <= 0;
                one_score   <= 0;
                two_score   <= 0;
                three_score <= 0;
                four_score  <= 0;
                five_score  <= 0;
                six_score   <= 0;
                seven_score <= 0;
                eight_score <= 0;
                nine_score  <= 0;
            end
        end
        RECG: begin
            mem_addr_counter <= mem_addr_counter + 1; 
            
            if (hcount < CELL_LR_WIDTH - 1) begin
                hcount <= hcount + 1;
            end else begin
                hcount <= 0;
                vcount <= vcount + 1;
            end
            
            // Main recognition loop
            if(mem_addr_counter == 256 + DELAY_CYCLES) begin
                state <= RECONF;
            end else
            
            if(mem_addr_counter >= DELAY_CYCLES) begin
                none_score  <= none_score   + (pix_logical == 1);
                one_score   <= one_score    + ~(pix_logical == one_d);
                two_score   <= two_score    + ~(pix_logical == two_d);
                three_score <= three_score  + ~(pix_logical == three_d);
                four_score  <= four_score   + ~(pix_logical == four_d);
                five_score  <= five_score   + ~(pix_logical == five_d);
                six_score   <= six_score    + ~(pix_logical == six_d);
                seven_score <= seven_score  + ~(pix_logical == seven_d);
                eight_score <= eight_score  + ~(pix_logical == eight_d);
                nine_score  <= nine_score   + ~(pix_logical == nine_d);
            end
        end
        RECONF: begin
            // Shift
            recg_sudoku <= {max_score, recg_sudoku[323:4]};
            mem_addr_counter <= 0;
            hcount <= 0;
            vcount <= 0;
            
            none_score  <= 0;
            one_score   <= 0;
            two_score   <= 0;
            three_score <= 0;
            four_score  <= 0;
            five_score  <= 0;
            six_score   <= 0;
            seven_score <= 0;
            eight_score <= 0;
            nine_score  <= 0;
        
            if(x0 <= 144 - CELL_LR_WIDTH - 1) begin
                x0 <= x0 + CELL_LR_WIDTH;

                state <= RECG;
            end else if(y0 <= 144 - CELL_LR_WIDTH - 1) begin
                y0 <= y0 + CELL_LR_WIDTH;
                x0 <= 0;

                state <= RECG;
            end else begin
                state <= IDLE;
            end
        end
    endcase
end

assign done = ~start && (state == IDLE);

endmodule
