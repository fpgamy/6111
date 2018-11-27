`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2018 08:29:50 PM
// Design Name: 
// Module Name: bram_quarantine
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


module bram_quarantine(
        input clk,
        input[7:0] addr,
        
        output one_d,
        output two_d,
        output three_d,
        output four_d,
        output five_d,
        output six_d,
        output seven_d,
        output eight_d,
        output nine_d
    );
    
    one_16_d one_16_d_1 (
        .clka(clk),
        .addra(addr),
        .douta(one_d));
        
    two_16_d two_16_d_1 (
        .clka(clk),
        .addra(addr),
        .douta(two_d));
        
    three_16_d three_16_d_1 (
        .clka(clk),
        .addra(addr),
        .douta(three_d));
        
    four_16_d four_16_d_1 (
        .clka(clk),
        .addra(addr),
        .douta(four_d));
        
    five_16_d five_16_d_1 (
        .clka(clk),
        .addra(addr),
        .douta(five_d));
        
    six_16_d six_16_d_1 (
        .clka(clk),
        .addra(addr),
        .douta(six_d));
        
    seven_16_d seven_16_d_1 (
        .clka(clk),
        .addra(addr),
        .douta(seven_d));
        
    eight_16_d eight_16_d_1 (
        .clka(clk),
        .addra(addr),
        .douta(eight_d));
        
    nine_16_d nine_16_d_1 (
        .clka(clk),
        .addra(addr),
        .douta(nine_d));
        
endmodule
