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
        
        output reg[7:0] rom_addr,
        
        input one_rom_data,
        input two_rom_data,
        input three_rom_data,
        input four_rom_data,
        input five_rom_data,
        input six_rom_data,
        input seven_rom_data,
        input eight_rom_data,
        input nine_rom_data,            
        
        output reg[323:0] recg_sudoku
                           
    );

parameter IMG_WIDTH = 144;
parameter DELAY_CYCLES = 3;
    
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

parameter THRESHOLD = 15;
parameter CELL_WIDTH = 16;

//assign rom_addr = ;

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
    
always @(posedge clk) begin
    img_ram_addr <= x + y * IMG_WIDTH;
    rom_addr <= hcount + vcount * CELL_WIDTH;
    case(state)
        IDLE: begin
            if(start) begin
                state <= RECG;
                cycle_counter <= 0;
                mem_addr_counter <= 0;
                recg_sudoku <= 0;
                x0 <= 0;
                y0 <= 0;
                
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
            
            if (hcount < CELL_WIDTH - 1) begin
                hcount <= hcount + 1;
            end else begin
                hcount <= 0;
                vcount <= vcount + 1;
            end
            
            // Main recognition loop
            if(mem_addr_counter == 256 + DELAY_CYCLES) begin
                state <= RECONF;
            end else
            
            if(mem_addr_counter > DELAY_CYCLES) begin
                none_score  <= none_score   + (pix_logical == 0);
                one_score   <= one_score    + (pix_logical == one_rom_data);
                two_score   <= two_score    + (pix_logical == two_rom_data);
                three_score <= three_score  + (pix_logical == three_rom_data);
                four_score  <= four_score   + (pix_logical == four_rom_data);
                five_score  <= five_score   + (pix_logical == five_rom_data);
                six_score   <= six_score    + (pix_logical == six_rom_data);
                seven_score <= seven_score  + (pix_logical == seven_rom_data);
                eight_score <= eight_score  + (pix_logical == eight_rom_data);
                nine_score  <= nine_score   + (pix_logical == nine_rom_data);
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
        
            if(x0 <= 144 - CELL_WIDTH - 1) begin
                x0 <= x0 + CELL_WIDTH;

                state <= RECG;
            end else if(y0 <= 144 - CELL_WIDTH - 1) begin
                y0 <= y0 + CELL_WIDTH;
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
