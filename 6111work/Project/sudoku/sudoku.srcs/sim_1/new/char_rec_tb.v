`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2018 08:33:57 PM
// Design Name: 
// Module Name: char_rec_tb
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


module char_rec_tb;

reg clk = 0;
reg start = 0;
wire done;

wire[14:0] img_ram_addr = 0;
reg[11:0] img_ram_data = 0;

wire[728:0] recg_sudoku;
wire[7:0] rom_addr;

char_rec uut (
    .clk(clk),
    .start(start),
    .done(done),
    .img_ram_addr(img_ram_addr),
    .img_ram_data(img_ram_data),
    .rom_addr(rom_addr),
    .one_rom_data(1'b0),
    .two_rom_data(1'b0),
    .three_rom_data(1'b0),
    .four_rom_data(1'b0),
    .five_rom_data(1'b0),
    .six_rom_data(1'b0),
    .seven_rom_data(1'b0),
    .eight_rom_data(1'b0),
    .nine_rom_data(1'b0));
    
initial begin
    #200;
    start = 1;
    #20;
    start = 0;
end
    
always #10 clk = ~clk;
endmodule
