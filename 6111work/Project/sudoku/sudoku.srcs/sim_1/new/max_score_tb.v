`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2018 02:11:35 PM
// Design Name: 
// Module Name: max_score_tb
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


module max_score_tb;

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
wire[3:0] max_score;

max_score uut(
    .none_score(none_score),
    .one_score(one_score),
    .two_score(two_score),
    .three_score(three_score),
    .four_score(four_score),
    .five_score(five_score),
    .six_score(six_score),
    .seven_score(seven_score),
    .eight_score(eight_score),
    .nine_score(nine_score));
    
initial begin
    #100 one_score = 166;
end
endmodule
