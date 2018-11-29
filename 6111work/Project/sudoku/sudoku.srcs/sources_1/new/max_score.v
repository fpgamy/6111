`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2018 05:20:23 PM
// Design Name: 
// Module Name: max_score
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


module max_score(
        input[8:0] none_score,
        input[8:0] one_score,
        input[8:0] two_score,
        input[8:0] three_score,
        input[8:0] four_score,
        input[8:0] five_score,
        input[8:0] six_score,
        input[8:0] seven_score,
        input[8:0] eight_score,
        input[8:0] nine_score,
        output[3:0] max_score_out
    );

reg[3:0] max_score = 0;
assign max_score_out = max_score;
always @* begin
    // Warning: Stupidity ahead
    if(none_score >= one_score &&
       none_score >= two_score && 
       none_score >= three_score && 
       none_score >= four_score && 
       none_score >= five_score && 
       none_score >= six_score && 
       none_score >= seven_score && 
       none_score >= eight_score && 
       none_score >= nine_score) begin
       
       max_score = 0;
    end else 
    if(one_score >= one_score &&
       one_score >= two_score && 
       one_score >= three_score && 
       one_score >= four_score && 
       one_score >= five_score && 
       one_score >= six_score && 
       one_score >= seven_score && 
       one_score >= eight_score && 
       one_score >= nine_score) begin
       
       max_score = 1;
    end else
    if(two_score >= one_score &&
       two_score >= two_score && 
       two_score >= three_score && 
       two_score >= four_score && 
       two_score >= five_score && 
       two_score >= six_score && 
       two_score >= seven_score && 
       two_score >= eight_score && 
       two_score >= nine_score) begin
       
       max_score = 2;
    end else
    if(three_score >= one_score &&
       three_score >= two_score && 
       three_score >= three_score && 
       three_score >= four_score && 
       three_score >= five_score && 
       three_score >= six_score && 
       three_score >= seven_score && 
       three_score >= eight_score && 
       three_score >= nine_score) begin
       
       max_score = 3;
    end else
    if(four_score >= one_score &&
       four_score >= two_score && 
       four_score >= three_score && 
       four_score >= four_score && 
       four_score >= five_score && 
       four_score >= six_score && 
       four_score >= seven_score && 
       four_score >= eight_score && 
       four_score >= nine_score) begin
       
       max_score = 4;
    end else
    if(five_score >= one_score &&
       five_score >= two_score && 
       five_score >= three_score && 
       five_score >= four_score && 
       five_score >= five_score && 
       five_score >= six_score && 
       five_score >= seven_score && 
       five_score >= eight_score && 
       five_score >= nine_score) begin
       
       max_score = 5;
    end else
    if(six_score >= one_score &&
       six_score >= two_score && 
       six_score >= three_score && 
       six_score >= four_score && 
       six_score >= five_score && 
       six_score >= six_score && 
       six_score >= seven_score && 
       six_score >= eight_score && 
       six_score >= nine_score) begin
       
       max_score = 6;
    end else
    if(seven_score >= one_score &&
       seven_score >= two_score && 
       seven_score >= three_score && 
       seven_score >= four_score && 
       seven_score >= five_score && 
       seven_score >= six_score && 
       seven_score >= seven_score && 
       seven_score >= eight_score && 
       seven_score >= nine_score) begin
       
       max_score = 7;
    end else
    if(eight_score >= one_score &&
       eight_score >= two_score && 
       eight_score >= three_score && 
       eight_score >= four_score && 
       eight_score >= five_score && 
       eight_score >= six_score && 
       eight_score >= seven_score && 
       eight_score >= eight_score && 
       eight_score >= nine_score) begin
       
       max_score = 8;
    end else
    if(nine_score >= one_score &&
       nine_score >= two_score && 
       nine_score >= three_score && 
       nine_score >= four_score && 
       nine_score >= five_score && 
       nine_score >= six_score && 
       nine_score >= seven_score && 
       nine_score >= eight_score && 
       nine_score >= nine_score) begin
       
       max_score = 9;
    end
end
endmodule
