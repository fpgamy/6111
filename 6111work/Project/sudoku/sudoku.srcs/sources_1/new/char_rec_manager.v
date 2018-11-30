`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2018 08:26:44 PM
// Design Name: 
// Module Name: char_rec_manager
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


module get_board(
        clk_in,
        start_in,
        done_out,
        
        img_addr_out,
        img_data_in,
        
        board_out
    );
    
    `include "common_lib.v"
    parameter IMG_SIZE = 16;
    
    localparam CELL_LR_WIDTH = 16;
    localparam MEM_SIZE = IMG_SIZE * IMG_SIZE;
        
    reg[MEM_SIZE-1:0] img_flattened = 0;
    
    input clk_in, start_in;
    output done_out;
    
    output[14:0] img_addr_out;
    input[11:0] img_data_in;
    
    output wire [4*(GRID_SIZE)*(GRID_SIZE)-1:0] board_out;
    
    // States
    
    localparam IDLE = 0;
    localparam READING = 1;
    localparam RECG = 2;
    
    reg[1:0] state = IDLE;

    reg[8:0] addr = 0;
    
    `INST_ROM(one_16_d, one_16_d_1, clk_in, addr, one_d);
    `INST_ROM(two_16_d, two_16_d_1, clk_in, addr, two_d);
    `INST_ROM(three_16_d, three_16_d_1, clk_in, addr, three_d);
    `INST_ROM(four_16_d, four_16_d_1, clk_in, addr, four_d);
    `INST_ROM(five_16_d, five_16_d_1, clk_in, addr, five_d);
    `INST_ROM(six_16_d, six_16_d_1, clk_in, addr, six_d);
    `INST_ROM(seven_16_d, seven_16_d_1, clk_in, addr, seven_d);
    `INST_ROM(eight_16_d, eight_16_d_1, clk_in, addr, eight_d);
    `INST_ROM(nine_16_d, nine_16_d_1, clk_in, addr, nine_d);
    
    localparam DELAY_CYCLES = 2;
    localparam THRESHOLD = 15;
    
    reg[14:0] mem_addr = 0;
    reg[8:0] pixel_counter = 0;
    
    // Combined R, G, and B channels
    wire[5:0] pixel_combined;
    assign pixel_combined = img_data_in[3:0] + img_data_in[7:4] + img_data_in[11:8];
    
    wire pix_bin;
    assign pix_bin = pixel_combined > THRESHOLD;
    wire start_recg;
    assign start_recg = (addr >= DELAY_CYCLES);
    wire done;
    assign done = (pixel_counter == 256);
    assign done_out = done;
    wire [3:0] board [0:(GRID_SIZE-1)] [0:(GRID_SIZE-1)];
    
    assign board_out = {board[0][0], board[0][1], board[0][2], board[0][3], board[0][4], board[0][5], board[0][6], board[0][7], board[0][8],
                                board[1][0], board[1][1], board[1][2], board[1][3], board[1][4], board[1][5], board[1][6], board[1][7], board[1][8],
                                board[2][0], board[2][1], board[2][2], board[2][3], board[2][4], board[2][5], board[2][6], board[2][7], board[2][8],
                                board[3][0], board[3][1], board[3][2], board[3][3], board[3][4], board[3][5], board[3][6], board[3][7], board[3][8],
                                board[4][0], board[4][1], board[4][2], board[4][3], board[4][4], board[4][5], board[4][6], board[4][7], board[4][8],
                                board[5][0], board[5][1], board[5][2], board[5][3], board[5][4], board[5][5], board[5][6], board[5][7], board[5][8],
                                board[6][0], board[6][1], board[6][2], board[6][3], board[6][4], board[6][5], board[6][6], board[6][7], board[6][8],
                                board[7][0], board[7][1], board[7][2], board[7][3], board[7][4], board[7][5], board[7][6], board[7][7], board[7][8],
                                board[8][0], board[8][1], board[8][2], board[8][3], board[8][4], board[8][5], board[8][6], board[8][7], board[8][8]};
    generate
    genvar row_genvar;
    genvar col_genvar;
    
    for (row_genvar = 0; row_genvar < GRID_SIZE; row_genvar = row_genvar + 1)
    begin: row_rec_gen
        for (col_genvar = 0; col_genvar < GRID_SIZE; col_genvar = col_genvar + 1)
        begin: col_rec_gen
            wire [255:0] cell_data;
            assign cell_data = {
            img_flattened[ (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(0*IMG_SIZE)+15) : (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(0*IMG_SIZE))],
            img_flattened[ (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(1*IMG_SIZE)+15) : (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(1*IMG_SIZE))],
            img_flattened[ (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(2*IMG_SIZE)+15) : (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(2*IMG_SIZE))],
            img_flattened[ (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(3*IMG_SIZE)+15) : (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(3*IMG_SIZE))],
            img_flattened[ (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(4*IMG_SIZE)+15) : (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(4*IMG_SIZE))],
            img_flattened[ (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(5*IMG_SIZE)+15) : (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(5*IMG_SIZE))],
            img_flattened[ (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(6*IMG_SIZE)+15) : (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(6*IMG_SIZE))],
            img_flattened[ (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(7*IMG_SIZE)+15) : (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(7*IMG_SIZE))],
            img_flattened[ (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(8*IMG_SIZE)+15) : (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(8*IMG_SIZE))],
            img_flattened[ (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(9*IMG_SIZE)+15) : (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(9*IMG_SIZE))],
            img_flattened[ (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(10*IMG_SIZE)+15) : (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(10*IMG_SIZE))],
            img_flattened[ (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(11*IMG_SIZE)+15) : (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(11*IMG_SIZE))],
            img_flattened[ (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(12*IMG_SIZE)+15) : (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(12*IMG_SIZE))],
            img_flattened[ (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(13*IMG_SIZE)+15) : (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(13*IMG_SIZE))],
            img_flattened[ (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(14*IMG_SIZE)+15) : (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(14*IMG_SIZE))],
            img_flattened[ (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(15*IMG_SIZE)+15) : (((CELL_LR_WIDTH * col_genvar) + (CELL_LR_WIDTH * IMG_SIZE * row_genvar))+(15*IMG_SIZE))]
            };

                                        
                                        
            char_rec_cell cell_rec ( .clk_in(clk_in),
                                     .done_in(done),
                                     .start_in(start_recg),
                                     .one_in(one_d),
                                     .two_in(two_d),
                                     .three_in(three_d),
                                     .four_in(four_d),
                                     .five_in(five_d),
                                     .six_in(six_d),
                                     .seven_in(seven_d),
                                     .eight_in(eight_d),
                                     .nine_in(nine_d),
                                     .cell_data_in(cell_data),
                                     .majority_out(board[row_genvar][col_genvar])
                                   );
        end
    end
    endgenerate
    
    always @(posedge clk_in) begin
        case(state)
            IDLE: begin
                if(start_in) begin
                    state <= READING;
                    mem_addr <= 0;
                    pixel_counter <= 0;
                    addr <= 0;
                end
            end
            READING: begin
                mem_addr <= mem_addr + 1;
                
                if(mem_addr >= ((MEM_SIZE - 1) + DELAY_CYCLES)) begin
                    state <= RECG;
                end else
                if(mem_addr >= DELAY_CYCLES) begin
                    img_flattened <= {pix_bin, img_flattened[MEM_SIZE-1:1]};
                end
            end
            RECG: begin
                addr <= addr + 1;
                
                if(done) begin
                    state <= IDLE;
                end else
                if (addr >= DELAY_CYCLES) begin
                    pixel_counter <= addr - DELAY_CYCLES;
                end
                
            end
        endcase
    end
        
endmodule
