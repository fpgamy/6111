`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2018 07:27:57 PM
// Design Name: 
// Module Name: char_rec_cell
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


module char_rec_cell(clk_in,
                     done_in,
                     start_in,
//                     count_in,
                     one_in,
                     two_in,
                     three_in,
                     four_in,
                     five_in,
                     six_in,
                     seven_in,
                     eight_in,
                     nine_in,
                     cell_data_in,
                     majority_out);
          
    `include "common_lib.v"
                     
    input clk_in;
//    input[7:0] count_in;
    input start_in;
    input done_in;
    input one_in, two_in, three_in, four_in, five_in, six_in, seven_in, eight_in, nine_in;
    input [255:0] cell_data_in;
    
    output [3:0] majority_out;
    // Probabilities
    
    reg[8:0] one_score = 0;
    reg[8:0] two_score = 0;
    reg[8:0] three_score = 0;
    reg[8:0] four_score = 0;
    reg[8:0] five_score = 0;
    reg[8:0] six_score = 0;
    reg[8:0] seven_score = 0;
    reg[8:0] eight_score = 0;
    reg[8:0] nine_score = 0;
    reg[8:0] best_score = 0;
    reg[255:0] cell_data_reg = 0;
    reg[3:0] majority_num = 0;
    wire [8:0] one_hot_score;
    
    // Best threshold comes from smallest number 255 minus (1) 
    // Equivalent to saying the intersection of empty and the smallest number
    localparam BEST_THRESH = 225;
    
    assign one_hot_score = {(nine_score == best_score),
                            (eight_score == best_score),
                            (seven_score == best_score),
                            (six_score == best_score),
                            (five_score == best_score),
                            (four_score == best_score),
                            (three_score == best_score),
                            (two_score == best_score),
                            (one_score == best_score)};
                            
    assign majority_out = ((best_score < BEST_THRESH) && (majority_num == 1)) ? 0 : majority_num; 
    
    always @(posedge clk_in) 
    begin
        if (start_in)
        begin
            cell_data_reg <= cell_data_in;
            
            one_score   <= 0;
            two_score   <= 0;
            three_score <= 0;
            four_score  <= 0;
            five_score  <= 0;
            six_score   <= 0;
            seven_score <= 0;
            eight_score <= 0;
            nine_score  <= 0;
            best_score  <= 0;           
            majority_num <= 0;
        end
        else
        begin
            if(done_in)
            begin
                best_score <= `MAX_OUT_OF_NINE(one_score, two_score, three_score, four_score, five_score, six_score, seven_score, eight_score, nine_score);
                majority_num <= bcd(`GET_LSB(one_hot_score));                                      
            end
            
            one_score       <= one_score    + (cell_data_reg[255] == one_in);
            two_score       <= two_score    + (cell_data_reg[255] == two_in);
            three_score     <= three_score  + (cell_data_reg[255] == three_in);
            four_score      <= four_score   + (cell_data_reg[255] == four_in);
            five_score      <= five_score   + (cell_data_reg[255] == five_in);
            six_score       <= six_score    + (cell_data_reg[255] == six_in);
            seven_score     <= seven_score  + (cell_data_reg[255] == seven_in);
            eight_score     <= eight_score  + (cell_data_reg[255] == eight_in);
            nine_score      <= nine_score   + (cell_data_reg[255] == nine_in); 
            cell_data_reg   <= {cell_data_reg[254:0], 1'b0};   

        end
    end
endmodule
