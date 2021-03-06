`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2018 12:22:32 PM
// Design Name: 
// Module Name: display_grid
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

module display_grid(
        clk_in,
        x_in,
        y_in,
        board_in,
        rgb_out,
        selected_x,
        selected_y,
        state,
        use_staff
    );
    
    parameter CELL_PIXELS = 48;
    
    `include "common_lib.v"
    
    `include "display_lib.v"
    
    input clk_in;
    input [9:0] x_in, y_in;
    input  [4*(GRID_SIZE)*(GRID_SIZE)-1:0] board_in;
    input use_staff;
    
    output [11:0] rgb_out;
    
    input[3:0] selected_x;
    input[3:0] selected_y;
    input[3:0] state;
    wire  [3:0] board [0:(GRID_SIZE-1)] [0:(GRID_SIZE-1)];
    
    generate
        genvar row_genvar;
        genvar col_genvar;
    
        for (row_genvar = 0; row_genvar < (GRID_SIZE); row_genvar = row_genvar + 1)
        begin: row_generator
            for (col_genvar = 0; col_genvar < (GRID_SIZE); col_genvar = col_genvar + 1)
            begin: col_generator
                assign board[row_genvar][col_genvar] = board_in[(row_genvar*GRID_SIZE*4)+(col_genvar*4)+3:(row_genvar*GRID_SIZE*4)+(col_genvar*4)];
            end
        end
    endgenerate
    
    wire [3:0] row_num;
    wire [3:0] col_num;
    
    assign row_num = get_line(y_in);
    assign col_num = get_line(x_in);
    
    wire [9:0] start_x;
    wire [9:0] start_y;
    
    assign start_x = (col_num-1) * CELL_PIXELS;
    assign start_y = (row_num-1) * CELL_PIXELS;
    
    wire [11:0] address_arr [47:0];
    
    generate
        genvar addr_genvar;
        for (addr_genvar = 0; addr_genvar < (CELL_PIXELS); addr_genvar = addr_genvar + 1)
        begin: addr_generator
            wire [11:0] addr_x_component;
            wire [11:0] addr_y_component;
            
            assign addr_y_component = (y_in == (start_y + addr_genvar)) ? (CELL_PIXELS * addr_genvar) : 0;
            assign addr_x_component = (y_in == (start_y + addr_genvar)) ? (x_in - start_x) : 0;
            assign address_arr[addr_genvar] = addr_y_component + addr_x_component;      
        end
    endgenerate
    
    wire one_black;
    wire two_black;
    wire three_black;
    wire four_black;
    wire five_black;
    wire six_black;
    wire seven_black;
    wire eight_black;
    wire nine_black;
    
    wire aaron_black;
    wire diana_black;
    wire driss_black;
    wire gim_black;
    wire melinda_black;
    wire mike_black;
    wire victor_black;
    wire yeung_black;
    wire joe_black;
    
    wire one_n;
    wire two_n;
    wire three_n;
    wire four_n;
    wire five_n;
    wire six_n;
    wire seven_n;
    wire eight_n;
    wire nine_n;
    
    wire [11:0] rom_addr = `OR_ARR(address_arr);
    
    one_image_48_48   rom_1(.clka(clk_in),      .addra(rom_addr), .douta(one_black));
    two_image_48_48   rom_2(.clka(clk_in),      .addra(rom_addr), .douta(two_black));
    three_image_48_48 rom_3(.clka(clk_in),      .addra(rom_addr), .douta(three_black));
    four_image_48_48  rom_4(.clka(clk_in),      .addra(rom_addr), .douta(four_black));
    five_image_48_48  rom_5(.clka(clk_in),      .addra(rom_addr), .douta(five_black));
    six_image_48_48   rom_6(.clka(clk_in),      .addra(rom_addr), .douta(six_black));
    seven_image_48_48 rom_7(.clka(clk_in),      .addra(rom_addr), .douta(seven_black));
    eight_image_48_48 rom_8(.clka(clk_in),      .addra(rom_addr), .douta(eight_black));
    nine_image_48_48  rom_9(.clka(clk_in),      .addra(rom_addr), .douta(nine_black));
    
    aaron             aaron_1(.clka(clk_in),    .addra(rom_addr), .douta(aaron_black));
    diana             diana_1(.clka(clk_in),    .addra(rom_addr), .douta(diana_black));
    driss             driss_1(.clka(clk_in),    .addra(rom_addr), .douta(driss_black));
    gim               gim_1(.clka(clk_in),      .addra(rom_addr), .douta(gim_black));
    melinda           melinda_1(.clka(clk_in),  .addra(rom_addr), .douta(melinda_black));
    mike              mike_1(.clka(clk_in),     .addra(rom_addr), .douta(mike_black));
    victor            victor_1(.clka(clk_in),   .addra(rom_addr), .douta(victor_black));
    yeung             yeung_1(.clka(clk_in),    .addra(rom_addr), .douta(yeung_black));
    joe               joe_1(.clka(clk_in),      .addra(rom_addr), .douta(joe_black));
    
    assign one_n        = (use_staff) ? ~aaron_black    : one_black;
    assign two_n        = (use_staff) ? ~driss_black    : two_black;
    assign three_n      = (use_staff) ? ~gim_black      : three_black;
    assign four_n       = (use_staff) ? ~melinda_black  : four_black;
    assign five_n       = (use_staff) ? ~mike_black     : five_black;
    assign six_n        = (use_staff) ? ~victor_black   : six_black;
    assign seven_n      = (use_staff) ? ~yeung_black    : seven_black;
    assign eight_n      = (use_staff) ? ~joe_black      : eight_black;
    assign nine_n       = (use_staff) ? ~diana_black    : nine_black;
    
    assign rgb_out = `ONBORDER(x_in, y_in) ? 12'h777 : 
                        (`ONGRID(x_in, y_in) ? 12'h111 :
                        (pick_num(board[row_num-1][col_num-1],
                                one_n,
                                two_n,
                                three_n,
                                four_n,
                                five_n,
                                six_n,
                                seven_n,
                                eight_n,
                                nine_n) ? 0 : ((selected_x == (col_num - 1) && selected_y == (row_num - 1) && (state == 9 || state == 6)) ? 12'h0F0 : 12'hFFF)));                              
    
endmodule
